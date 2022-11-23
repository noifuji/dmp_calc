import 'Dart:math';

import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/exception/dmp_calc_exception.dart';
import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/deck.dart';
import 'package:dmp_calc/model/deck_item.dart';
import 'package:flutter/foundation.dart';

import '../repository/card_specs_repository.dart';
import '../../assets/constants.dart' as constants;
import 'package:uuid/uuid.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class CreateDeckUseCase {
  DeckRepository _deckRepository;
  CardSpecsRepository _cardSpecsRepository;

  CreateDeckUseCase(this._deckRepository, this._cardSpecsRepository);

  Future<void> execute(String url) async {
    Uri uri;
    //urlをデコード
    try {
      uri = Uri.parse(url);
    } on FormatException {
      throw DmpCalcException('エラー:デッキURLがおかしいです。');
    }
    List<String>? ids = uri.queryParameters['c']?.split('.');
    List<String>? psychicIds = uri.queryParameters['s']?.split('.');
    if (ids == null) {
      throw DmpCalcException('エラー:デッキURLがおかしいです。');
    }



    List<String> cardIds = ids.map((e) => decodeCardId(e)).toList();
    //シークレットを通常版に修正
    cardIds = cardIds.map((e) => e.substring(0,e.length-2) + "00").toList();
    if (kDebugMode) {
      print(cardIds);
    }
    List<String> distinctCardIds = cardIds.toSet().toList();
    List<CardSpecs> cards = await _cardSpecsRepository.getList(distinctCardIds);
    List<DeckItem> deckItems = cards
        .map((e) => DeckItem(
            card: e,
            quantity: cardIds.where((element) => element == e.id).length,
            zone: ZoneType.main))
        .toList();

    //デッキ名取得
    String name = generateDeckName(deckItems);

    if (!kDebugMode) {
      await FirebaseAnalytics.instance.logEvent(
        name: "add_deck",
        parameters: {
          "deck_name": name,
          "url": url,
        },
      );
    }

    //サイキッククリーチャーの処理
    if (psychicIds != null && psychicIds.isNotEmpty && psychicIds[0] != "") {
      List<String> psychicCardIds =
          psychicIds.map((e) => decodeCardId(e)).toList();
      List<CardSpecs> psychicCards =
          await _cardSpecsRepository.getList(psychicCardIds);

      //複数のサイキックカードが1つのオリジナルカードにひもつく場合の処理
      //オリジナルID:カード、のマップを作成
      //
      //カードIDが異なり、オリジナルIDが一致するカードを探す
      //カードIDのうち最大枚数をオリジナルIDの枚数とする。
      Map<String, List<CardSpecs>> originalIdAndPsychicMap = {};
      for (var psychic in psychicCards) {
        if (psychic.originalCardId != null) {
          CardSpecs c =
              await _cardSpecsRepository.getOne(psychic.originalCardId!);
          if (originalIdAndPsychicMap[c.id] == null) {
            originalIdAndPsychicMap[c.id] = [psychic];
          } else {
            originalIdAndPsychicMap[c.id]!.add(psychic);
          }
        }
      }

      //オリジナルカードのリストを作成
      List<DeckItem> originalDeckItems =
          (await Future.wait(originalIdAndPsychicMap.keys.map((e) async {
        Map<String, int> a =
            originalIdAndPsychicMap[e]!.fold<Map<String, int>>({}, (prev, ele) {
          if (prev[ele.id] == null) {
            prev[ele.id] = 1;
          } else {
            prev[ele.id] = prev[ele.id]! + 1;
          }
          return prev;
        });
        return DeckItem(
            card: await _cardSpecsRepository.getOne(e),
            quantity: a.values.toList().reduce(max),
            zone: ZoneType.main);
      }))).toList();

      //deckItemsと比較して、必要枚数を変更
      for (var original in originalDeckItems) {
        int index = deckItems
            .indexWhere((element) => element.card.name == original.card.name);

        if (index < 0) {
          deckItems.add(original);
        } else {
          if (original.quantity > deckItems[index].quantity) {
            deckItems[index].quantity = original.quantity;
          }
        }
      }
    }

    await _deckRepository.insert(
        Deck(id: Uuid().v1(), name: name, url: url, deckItems: deckItems));
  }

  /*
    デッキ名の種類
    色 + (フィニッシャー | 種族 | 速攻)

    -色の確認
    -フィニッシャー
     登録されたフィニッシャーをもつか確認
    -種族を確認
     種族が半分以上同じなら種族デッキ確定
    -クリーチャーのコスト確認
     3コスト以下が半分以上なら速攻認定
    -最もレアリティが高く、コストが高く、idの大きいクリーチャーをコンセプトとする。
    */
  String generateDeckName(List<DeckItem> deckItems) {
    String deckName = "";
    //デッキ色取得
    List<String> colors = getDeckColor(deckItems);
    Map<String, String> deckColors =
        constants.DECK_COLORS.firstWhere((x) => x['color'] == colors.join(""));

    deckName = deckName + deckColors['name']!;

    //フィニッシャーチェック
    List<Map<String, String>> finishers = constants.FINISHER_LIST.where((x) {
      for (var c in deckItems) {
        if (c.card.id == x['id']) {
          return true;
        }
      }
      return false;
    }).toList();

    if (finishers.isNotEmpty) {
      //フィニッシャーが天門の場合はサブコンセプトも追加する。
      if (finishers.where((element) => element['id'] == "60100").isNotEmpty &&
          finishers.length > 1) {
        return deckName +
            finishers.firstWhere(
                (element) => element['id'] == "60100")['abbreviation']! +
            finishers.firstWhere(
                (element) => element['id'] != "60100")['abbreviation']!;
      }

      //フィニッシャーがゲートの場合はサブコンセプトも追加する。
      if (finishers.where((element) => element['id'] == "93700").isNotEmpty &&
          finishers.length > 1) {
        return deckName +
            finishers.firstWhere(
                (element) => element['id'] == "93700")['abbreviation']! +
            finishers.firstWhere(
                (element) => element['id'] != "93700")['abbreviation']!;
      }


      return deckName + finishers[0]['abbreviation']!;
    }

    //種族チェック
    //全種族抽出
    List<String> races = deckItems.fold(<String>[], (prev, curr) {
      for (int i = 0; i < curr.quantity; i++) {
        List<String> r = curr.card.race.split("／");
        for (var x in r) {
          if (x != "-" && x != "") {
            prev.add(x);
          }
        }
      }
      return prev;
    });

    //種族の集計を作成
    Map<String, int> raceSummary = races.fold(<String, int>{}, (accu, current) {
      accu[current] = accu[current] == null ? 1 : (accu[current]! + 1);
      return accu;
    });

    String theMostRace = raceSummary.keys
        .toList()
        .fold(raceSummary.keys.toList()[0], (prev, curr) {
      if (raceSummary[curr]! > raceSummary[prev]!) {
        return curr;
      }

      return prev;
    });

    if (raceSummary[theMostRace]! >= 20) {


      print("sss");
      return deckName + theMostRace;
    }

    //速攻チェック
    int creatureCountSmallerCost3 = deckItems.fold(0, (acc, cur) {
      if (cur.card.cost <= 3 && cur.card.type == "クリーチャー") {
        return acc + cur.quantity;
      }
      return acc;
    });

    if (creatureCountSmallerCost3 >= 20) {
      return deckName + "速攻";
    }

    //レアリティ最大、ID一番大きいものをコンセプトカードとする。
    DeckItem conceptCard = deckItems.reduce((prev, curr) {
      int compRarityResult = compareRarity(curr.card.rarity, prev.card.rarity);
      if (compRarityResult > 0) {
        return curr;
      } else if (compRarityResult < 0) {
        return prev;
      } else {
        if (int.parse(curr.card.id) > int.parse(prev.card.id)) {
          return curr;
        } else if (int.parse(curr.card.id) < int.parse(prev.card.id)) {
          return prev;
        } else {
          return curr;
        }
      }
    });

    return deckName + conceptCard.card.name;
  }

  int compareRarity(String a, String b) {
    Map<String, int> rarityDef = {
      "VIC": 110,
      "SR": 100,
      "PS": 95,
      "VR": 90,
      "R": 80,
      "UC": 70,
      "C": 60,
      "-": 50
    };

    if (rarityDef[a]! > rarityDef[b]!) {
      return 1;
    } else if (rarityDef[a]! < rarityDef[b]!) {
      return -1;
    } else {
      return 0;
    }
  }

  List<String> getDeckColor(List<DeckItem> deckItems) {
    const MANA_COLOR = [
      constants.MANA_COLOR_WHITE,
      constants.MANA_COLOR_BLUE,
      constants.MANA_COLOR_BLACK,
      constants.MANA_COLOR_RED,
      constants.MANA_COLOR_GREEN,
    ];

    return MANA_COLOR.where((x) {
      for (var c in deckItems) {
        if (c.card.manaColor.contains(x)) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  String decodeCardId(String encodedCardId) {
    var map = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567=";
    var padds = <String>["1", "8", "9", "0"];
    for (var x in padds) {
      encodedCardId = encodedCardId.replaceAll(x, "");
    }
    var ret = "";
    var length = encodedCardId.length;
    for (var j = 0; j < length; j = j + 2) {
      var val1 = encodedCardId.substring(j, j + 1);
      var val2 = encodedCardId.substring(j + 1, j + 2);
      var num1 = map.indexOf(val1);
      var num2 = map.indexOf(val2);
      if (num1 == 0) {
        if (num2.toString().length == 1) {
          ret = "00" + num2.toString() + ret;
        } else if (num2.toString().length == 2) {
          ret = "0" + num2.toString() + ret;
        }
      } else {
        ret = (num1 * 32 + num2).toString() + ret;
      }
    }
    var retInt = int.parse(ret);
    if (retInt != null) {
      return retInt.toString();
    } else {
      return "";
    }
  }
}
