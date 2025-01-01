import 'dart:convert';

import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/repository/api/card_specs_api.dart';
import 'package:csv/csv.dart' as csv;
import 'package:dmp_calc/model/repository/api/psychic_relation_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../assets/constants.dart' as constants;

class HttpPsychicRelationApi implements PsychicRelationApi {

  @override
  Future<Map<String, String>> fetchPsychicRelation() async {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var url = constants.psychicRelationUrl + "?nocache=$timestamp";
    Response response = await http.get(Uri.parse(url));
    String decodedResponseBody = Utf8Decoder().convert(response.bodyBytes);

    csv.CsvToListConverter converter= const csv.CsvToListConverter(
        eol: '\n', fieldDelimiter: ','
    );

    List<List> listCreated= converter.convert(decodedResponseBody);

    Map<String, String> map = {};
    for(var row in listCreated) {
      map[row[0].toString()] = row[1].toString();
    }

    return Future.value(map);
  }

}