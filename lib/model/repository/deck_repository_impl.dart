

import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/model/deck.dart';

import 'datasource/in_memory_deck_data_source.dart';

class DeckRepositoryImpl implements DeckRepository {
  InMemoryDeckDataSource _inMemoryDS;

  DeckRepositoryImpl(this._inMemoryDS);

  @override
  Future<void> delete(String id) async {
    _inMemoryDS.delete(id);
  }

  @override
  Future<List<Deck>> getAll() {
    return _inMemoryDS.getAll();
  }

  @override
  Future<void> insert(Deck deck) async {
    _inMemoryDS.insert(deck);
  }

}