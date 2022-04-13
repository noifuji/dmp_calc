

import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/domain/repository/inventory_repository.dart';
import 'package:dmp_calc/model/deck.dart';
import 'package:dmp_calc/model/inventory_item.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_inventory_data_source.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InMemoryInventoryDataSource _inMemoryDS;


  InventoryRepositoryImpl(this._inMemoryDS);


  @override
  Future<List<InventoryItem>> getList(List<String> cardIds) {
    return _inMemoryDS.getList(cardIds);
  }

  @override
  Future<InventoryItem> getOne(String cardId) {
    return _inMemoryDS.getOne(cardId);
  }

  @override
  Future<bool> updateQuantity(String cardId, int quantity) async {
    return _inMemoryDS.updateQuantity(cardId, quantity);
  }

  @override
  Future<void> insert(InventoryItem item) async {
    _inMemoryDS.insert(item);
  }

  @override
  Future<void> insertBulk(List<InventoryItem> items) async {
    _inMemoryDS.insertBulk(items);
  }

}