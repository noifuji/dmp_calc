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
import 'package:dmp_calc/model/repository/datasource/in_memory_deck_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dmp_calc/main.dart';

void main() {
  test('Deck data should be inserted, deleted and read. ', () async {
    InMemoryDeckDataSource deckDataSource = InMemoryDeckDataSource();

    CardSpecs cs =   CardSpecs(
        id:'1',name:'フェアリーライフ',race:'-',type:'呪文',manaColor: '緑',rarity:'C',
        cost:2,power: '3000',mana:1,text:'あああ',
        flavor: 'フレーバー',generateDmp:123,convertDmp:456,
        expansionCode: 'ベーシック',secretFlag: false);

    DeckItem item = DeckItem(card: cs, quantity:2, zone:ZoneType.main);
    Deck deck = Deck(id:'1', name:'test deck', url:'test url', deckItems:[item]);

    deckDataSource.insert(deck);

    List<Deck> decks = await deckDataSource.getAll();

    expect(decks.length, 1);
    expect(decks[0].id, '1');

    deckDataSource.delete(decks[0].id);

    decks = await deckDataSource.getAll();
    expect(decks.length, 0);

  });
}
