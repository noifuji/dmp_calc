// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/deck.dart';
import 'package:dmp_calc/model/deck_item.dart';
import 'package:dmp_calc/model/inventory_item.dart';
import 'package:dmp_calc/model/repository/api/http_card_specs_api.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_deck_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_inventory_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dmp_calc/main.dart';

void main() {
  test('CardSpecs data should be downloaded and parsed. ', () async {
    HttpCardSpecsApi httpCardSpecsApi = HttpCardSpecsApi();

    List<CardSpecs> cards =  await httpCardSpecsApi.fetchCardSpecs();

    CardSpecs card = cards.firstWhere((element) => element.id == '175300');

    expect(card.rarity, 'UC');
    expect(card.manaColor, '水火');

  });
}
