import '../../model/deck_item.dart';
import '../../model/inventory_item.dart';

class CalcDeckItemsCostUseCase {
  CalcDeckItemsCostUseCase();

  int execute(List<DeckItem> deckItems, List<InventoryItem> inventoryItems) {
    return deckItems.fold(0, (accu, curr) {

      if(curr.card.generateDmp <= 0) {
        return accu;
      }

      int inv = 0;

      try {
        inv = inventoryItems.firstWhere((element) => element.card.id == curr.card.id).quantity;
      } on StateError {
        inv = 0;
      }

      int necessary = (curr.quantity - inv) < 0? 0: (curr.quantity - inv);
      return accu + curr.card.generateDmp * necessary;
    });

  }

}