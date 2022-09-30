import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/repository/api/psychic_relation_api.dart';
import '../api/card_specs_api.dart';

class RemoteCardSpecsDataSource {
  final CardSpecsApi api;
  final PsychicRelationApi psychicRelationApi;

  RemoteCardSpecsDataSource(this.api, this.psychicRelationApi);

  Future<List<CardSpecs>> getAll() async {
    Map<String, String> relation =  await psychicRelationApi.fetchPsychicRelation();
    List<CardSpecs> cards = await api.fetchCardSpecs();
    
    cards = cards.map((e) {
      int i = relation.keys.toList().indexWhere((element) => element == e.id);
      if(i >= 0) {
        e.originalCardId = relation[relation.keys.toList()[i]];
      }

      return e;
    }).toList();
    
    return Future<List<CardSpecs>>.value(cards);
  }
}
