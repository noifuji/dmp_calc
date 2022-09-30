import 'package:dmp_calc/model/card_specs.dart';

abstract class PsychicRelationApi {
  Future<Map<String, String>> fetchPsychicRelation();
}