
import '../../model/deck.dart';

abstract class DeckRepository {
  Future<List<Deck>> getAll();
  Future<void> insert(Deck deck);
  Future<void> delete(String id);
}