import '../../deck.dart';

class InMemoryDeckDataSource {
  final List<Deck> _decks = <Deck>[];

  Future<void> insert(Deck deck) async {
    _decks.add(deck);
  }

  Future<List<Deck>> getAll() {
    return Future<List<Deck>>.value(_decks);
  }

  Future<void> delete(String id) async {
    _decks.remove(_decks.firstWhere((element) => element.id == id));
  }
}
