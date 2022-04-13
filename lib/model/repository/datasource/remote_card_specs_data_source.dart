import 'package:dmp_calc/model/card_specs.dart';
import '../api/card_specs_api.dart';

class RemoteCardSpecsDataSource {
  final CardSpecsApi api;

  RemoteCardSpecsDataSource(this.api);

  Future<List<CardSpecs>> getAll() {
    return Future<List<CardSpecs>>.value(api.fetchCardSpecs());
  }
}
