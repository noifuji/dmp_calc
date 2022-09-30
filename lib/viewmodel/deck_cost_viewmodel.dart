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

class DeckCostViewModel extends ChangeNotifier {
  late DeckRepository _deckRepository;
  late InventoryRepository _inventoryRepository;
  late CardSpecsRepository _cardSpecsRepository;

  int _totalCost = 0;
  List<Deck> _decks = <Deck>[];
  List<DeckItem> _uniqueDecksItems = <DeckItem>[];
  List<InventoryItem> _inventories = <InventoryItem>[];


  int get totalCost => _totalCost;
  List<Deck> get decks => _decks;
  List<DeckItem> get uniqueDecksItems => _uniqueDecksItems;
  List<InventoryItem> get inventories => _inventories;

  DeckCostViewModel(this._deckRepository, this._inventoryRepository, this._cardSpecsRepository);

  Future<void> addDeck(String deckUrl) async {
    CreateDeckUseCase createDeck = CreateDeckUseCase(_deckRepository, _cardSpecsRepository);
    try {
      await createDeck.execute(deckUrl);
    } on DmpCalcException {
      rethrow;
    }
    _decks = await _deckRepository.getAll();
    _uniqueDecksItems = getUniqueDeckItems(_decks);
    _totalCost = updateTotalDeckCost(_uniqueDecksItems, _inventories);
    notifyListeners();
  }

  Future<void> deleteDeck(String deckId) async {
    await _deckRepository.delete(deckId);
    _decks = await _deckRepository.getAll();
    _uniqueDecksItems = getUniqueDeckItems(_decks);
    _totalCost = updateTotalDeckCost(_uniqueDecksItems, _inventories);
    notifyListeners();
  }

  Future<void> updateInventoryCardQuantity(String cardId, int quantity) async {
    if(!await _inventoryRepository.updateQuantity(cardId, quantity)) {
      CardSpecs card = await _cardSpecsRepository.getOne(cardId);
      _inventoryRepository.insert(InventoryItem(card: card, quantity: quantity));
    }

    _inventories = await _inventoryRepository.getList(_uniqueDecksItems.map((e) => e.card.id).toList());
    _totalCost = updateTotalDeckCost(_uniqueDecksItems, _inventories);
    notifyListeners();
  }

  List<DeckItem> getUniqueDeckItems(List<Deck> decks) {
    DeleteDuplicateDeckItemsUseCase deleteDuplicates = DeleteDuplicateDeckItemsUseCase();
    return deleteDuplicates.execute(decks);
  }

  int updateTotalDeckCost(List<DeckItem> deckItems, List<InventoryItem> inventoryItems) {
    CalcDeckItemsCostUseCase calcCost = CalcDeckItemsCostUseCase();
    return calcCost.execute(deckItems, inventoryItems);
  }

  Map<String, int> getCostByExpansion() {
    List<String> expansions =
    _uniqueDecksItems.map((e) => e.card.expansionCode).toSet().toList();
    expansions = expansions.where((element) => element != "").toList();
    expansions.sort((a, b) => a.compareTo(b));

    List<int> expansionsDmp = expansions
        .map((x) {

          int expansionTotal = _uniqueDecksItems.fold<int>(0, (prev, req) {
            if(req.card.expansionCode == x) {
              int i = _inventories.indexWhere((element) => element.card.name == req.card.name);

              int total = 0;

              if(i < 0) {
                total = req.quantity * req.card.generateDmp;
              } else {
                total = req.quantity * req.card.generateDmp - _inventories[i].quantity * _inventories[i].card.generateDmp;
              }


              prev = prev + (total < 0? 0 : total);
            }

            return prev;
          });

          return expansionTotal;
        })
        .toList();

    for (int i = expansions.length - 1; i >= 0; i--) {
      if (expansionsDmp[i] <= 0) {
        expansions.removeAt(i);
        expansionsDmp.removeAt(i);
      }
    }

    Map<String, int> map = {};
    for(var i = 0; i < expansions.length ; i++) {
      map[expansions[i]] = expansionsDmp[i];
    }

    return map;
  }
}