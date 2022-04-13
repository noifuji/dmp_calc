import '../../model/deck.dart';
import '../../model/deck_item.dart';

class DeleteDuplicateDeckItemsUseCase {

  List<DeckItem> execute(List<Deck> decks) {
    List<DeckItem> deckItems = <DeckItem>[];
    List<DeckItem> distinctDeckItems = <DeckItem>[];

    for (var element in decks) {
      deckItems.addAll(element.deckItems);
    }

    //remove duplicates and use max quantity
    for(var e in deckItems) {
      if(distinctDeckItems.where((element) => element.card.id == e.card.id).isEmpty) {
        distinctDeckItems.add(e);
      } else {
        int duplicateIndex = distinctDeckItems.indexWhere((element) => element.card.id == e.card.id);
        if(distinctDeckItems[duplicateIndex].quantity < e.quantity) {
          distinctDeckItems[duplicateIndex].quantity = e.quantity;
        }
      }
    }

    //sort by cost
    distinctDeckItems.sort((a, b)=> a.card.cost.compareTo(b.card.cost));

    return distinctDeckItems;
  }

}