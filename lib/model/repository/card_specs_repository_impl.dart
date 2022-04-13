

import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/deck.dart';

import '../../domain/repository/card_specs_repository.dart';
import 'datasource/in_memory_card_specs_data_source.dart';
import 'datasource/remote_card_specs_data_source.dart';

class CardSpecsRepositoryImpl implements CardSpecsRepository {
  RemoteCardSpecsDataSource _remoteDS;
  InMemoryCardSpecsDataSource _inMemoryDS;


  CardSpecsRepositoryImpl(this._remoteDS, this._inMemoryDS);

  @override
  Future<List<CardSpecs>> getList(List<String> cardIds) async {
    int count = await _inMemoryDS.getCount();
    if(count == 0) {
      List<CardSpecs> list = await _remoteDS.getAll();
      await _inMemoryDS.insertBulk(list);
    }
    return _inMemoryDS.getList(cardIds);

  }

  @override
  Future<CardSpecs> getOne(String cardId) async {
    int count = await _inMemoryDS.getCount();
    if(count == 0) {
      List<CardSpecs> list = await _remoteDS.getAll();
      await _inMemoryDS.insertBulk(list);
    }
    return _inMemoryDS.getOne(cardId);
  }

  @override
  Future<List<CardSpecs>> getAll() async {
    int count = await _inMemoryDS.getCount();
    if(count == 0) {
      List<CardSpecs> list = await _remoteDS.getAll();
      await _inMemoryDS.insertBulk(list);
    }
    return _inMemoryDS.getAll();
  }


}