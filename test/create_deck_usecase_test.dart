// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/domain/usecase/create_deck_usecase.dart';
import 'package:dmp_calc/model/deck.dart';
import 'package:dmp_calc/model/repository/api/http_card_specs_api.dart';
import 'package:dmp_calc/model/repository/api/http_psychic_relation_api.dart';
import 'package:dmp_calc/model/repository/card_specs_repository_impl.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_deck_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/remote_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/deck_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Blue deck should have blue deck name. ', () async {
    DeckRepository deckRepo = DeckRepositoryImpl(InMemoryDeckDataSource());
    CreateDeckUseCase createDeck = CreateDeckUseCase(deckRepo,
        CardSpecsRepositoryImpl(RemoteCardSpecsDataSource(HttpCardSpecsApi(), HttpPsychicRelationApi()),
            InMemoryCardSpecsDataSource()));

    expect(createDeck.decodeCardId('PUAK'), '10500');

    await createDeck.execute('https://dmps.takaratomy.co.jp/deckbuilder/deck/?c=PUAK.PUAK.PUAK.PUAK.V4BE.V4BE.V4BE.V4BE.4EDY.4EDY.4EDY.SYDZ.SYDZ.SYDZ.SYDZ.V4DZ.V4DZ.V4DZ.V4DZ.ZAFV.ZAFV.GIFW.V4FW.V4FW.V4FW.ZAFW.ZAFW.ZAFW.ZAFW.GIFX.GIFX.GIFX.GIFX.GIGB.GIGB.GIGB.ZAGB.ZAGB.ZAGB.ZAGB&k=ZAFV&s=');

    List<Deck> decks = await deckRepo.getAll();
    expect(decks.length, 1);
    expect(decks[0].name, '青単速攻');

  });

  test('Psychic Deck. ', () async {
    DeckRepository deckRepo = DeckRepositoryImpl(InMemoryDeckDataSource());
    CreateDeckUseCase createDeck = CreateDeckUseCase(deckRepo,
        CardSpecsRepositoryImpl(RemoteCardSpecsDataSource(HttpCardSpecsApi(), HttpPsychicRelationApi()),
            InMemoryCardSpecsDataSource()));

    await createDeck.execute('https://dmps.takaratomy.co.jp/deckbuilder/deck/?c=JMAB.JMAB.JMAB.JMAB.PUAK.PUAK.PUAK.PUAK.GIFX.GIFX.GIFX.4EKL.4EKL.4EKL.ZAK6.4EK6.PUK7.SYK7.UAK7.ZAK7.AALA.GILA.JMLA.ZALA.AALB.DELB.DELB.GILB.JMLC.SYLC.TMLC.PULD.MQLF.ZALG.PULJ.SYLJ.TMLJ.V4LJ.JMLL.MQLL&k=TMLC&s=JMIT.KAIT&f=new');

    List<Deck> decks = await deckRepo.getAll();
    expect(decks.length, 1);
    expect(decks.first.deckItems.fold<int>(0, (previousValue, element) => element.quantity + previousValue), 42);

  });
}
