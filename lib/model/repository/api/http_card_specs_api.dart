import 'dart:convert';

import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/repository/api/card_specs_api.dart';
import 'package:csv/csv.dart' as csv;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../assets/constants.dart' as constants;

class HttpCardSpecsApi implements CardSpecsApi {
  @override
  Future<List<CardSpecs>> fetchCardSpecs() async {
    Response response = await http.get(Uri.parse(constants.cardMasterUrl));
    String decodedResponseBody = Utf8Decoder().convert(response.bodyBytes);

    csv.CsvToListConverter converter = const csv.CsvToListConverter(
        eol: '\n', fieldDelimiter: ','
    );



    List<List> listCreated = converter.convert(decodedResponseBody);
    List<CardSpecs> cardSpecsList = listCreated.where((row) => row.length >= 15)
        .map((e) {
      return CardSpecs(
          id: e[0].toString(),
          name: e[1].toString(),
          race: e[2].toString(),
          type: e[3].toString(),
          manaColor: e[4].toString(),
          rarity: e[5].toString(),
          cost: e[6] == '' ? -1 : e[6],
          power: e[7].toString(),
          mana: e[8] == '' ? 0 : e[8],
          text: e[9].toString(),
          flavor: e[10].toString(),
          generateDmp: e[11] == '-' ? 0 : e[11],
          convertDmp: e[12] == '-' ? 0 : e[12],
          expansionCode: e[13].toString(),
          secretFlag: e[14] != 0);
    }).toList();

    return Future<List<CardSpecs>>.value(cardSpecsList);
  }

}