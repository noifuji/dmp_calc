import 'package:dmp_calc/model/card_specs.dart';

abstract class CardSpecsApi {
  Future<List<CardSpecs>> fetchCardSpecs();
}