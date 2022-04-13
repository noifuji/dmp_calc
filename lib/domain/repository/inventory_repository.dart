
import 'package:dmp_calc/model/inventory_item.dart';

import '../../model/card_specs.dart';

abstract class InventoryRepository {
  Future<InventoryItem> getOne(String cardId);
  Future<bool> updateQuantity(String cardId, int quantity);
  Future<void> insert(InventoryItem item);
  Future<void> insertBulk(List<InventoryItem> items);
  Future<List<InventoryItem>> getList(List<String> cardIds);
}