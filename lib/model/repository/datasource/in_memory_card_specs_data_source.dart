import 'package:dmp_calc/model/card_specs.dart';

import '../../../exception/dmp_calc_exception.dart';

class InMemoryCardSpecsDataSource {
  final List<CardSpecs> _cardSpecs = <CardSpecs>[];

  Future<CardSpecs> getOne(String cardId) {
    return Future<CardSpecs>.value(_cardSpecs.firstWhere((element) => element.id == cardId));
  }

  Future<List<CardSpecs>> getAll() {
    return Future<List<CardSpecs>>.value(_cardSpecs);
  }

  Future<List<CardSpecs>> getList(List<String> cardIds) {
    return Future<List<CardSpecs>>.value(cardIds.map((e) => _cardSpecs.firstWhere((element) => element.id == e, orElse: () => throw DmpCalcException(
      "見つからないカードがあります。ブラウザを更新してみてください。"
    ))).toList());
  }

  Future<void> insertBulk(List<CardSpecs> cardSpecsList) async {
    _cardSpecs.addAll(cardSpecsList);
  }

  Future<int> getCount() {
    return Future<int>.value(_cardSpecs.length);
  }
}
