import 'package:dmp_calc/model/inventory_item.dart';

class InMemoryInventoryDataSource {
  final List<InventoryItem> _items = <InventoryItem>[];

  Future<List<InventoryItem>> getList(List<String> cardIds) {
    return Future<List<InventoryItem>>.value(cardIds.map((e) => _items.firstWhere((element) => element.card.id == e)).toList());
  }

  Future<InventoryItem> getOne(String cardId) {
    return Future<InventoryItem>.value(_items.firstWhere((element) => element.card.id == cardId));
  }

  Future<void> insertBulk(List<InventoryItem> items) async {
    _items.addAll(items);
  }

  Future<void> insert(InventoryItem item) async {
    _items.add(item);
  }

  Future<bool> updateQuantity(String cardId, int quantity) async {
    int targetIndex = _items.indexWhere((element) => element.card.id == cardId);

    if(targetIndex != -1) {
      _items[targetIndex].quantity = quantity;
      return true;
    } else {
      return false;
    }
  }


}
