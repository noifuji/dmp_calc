import 'package:dmp_calc/domain/usecase/create_deck_usecase.dart';
import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/domain/usecase/delete_duplicate_deck_items_usecase.dart';
import 'package:dmp_calc/exception/dmp_calc_exception.dart';
import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/repository/api/http_card_specs_api.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_inventory_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/remote_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/inventory_repository_impl.dart';
import 'package:flutter/material.dart';

import '../domain/usecase/calc_deck_items_cost_usecase.dart';
import '../domain/repository/card_specs_repository.dart';
import '../domain/repository/inventory_repository.dart';
import '../model/deck.dart';
import '../model/deck_item.dart';
import '../model/inventory_item.dart';
import '../model/repository/card_specs_repository_impl.dart';
import '../model/repository/datasource/in_memory_deck_data_source.dart';
import '../model/repository/deck_repository_impl.dart';

class DeckBuildingViewModel extends ChangeNotifier {
  late CardSpecsRepository _cardSpecsRepository;

  int _totalCost = 0;
  List<DeckItem> _decksItems = <DeckItem>[];

  int get totalCost => _totalCost;
  List<DeckItem> get decksItems => _decksItems;

  DeckBuildingViewModel(CardSpecsRepository repo) {
    _cardSpecsRepository = repo;
  }

  //同じ名前が無ければ追加
  //同じ名前があれば、数量を1追加
  void addDeckItem(DeckItem deckItem) {
    bool hasSameCard = _decksItems.fold<bool>(false, (prev, e) => (e.card.name == deckItem.card.name) || prev);

    if(hasSameCard) {
      int sameIndex = _decksItems.indexWhere((element) => element.card.name == deckItem.card.name);
      _decksItems[sameIndex].quantity++;
    } else {
      _decksItems.add(deckItem);
    }

    notifyListeners();
  }

  void search(String word) {

  }



}