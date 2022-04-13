import 'package:dmp_calc/model/deck_item.dart';

import 'card_specs.dart';

class Deck {

  Deck({required this.id, required this.name, required this.url, required this.deckItems});

  final String id;
  final String name;
  final String url;
  final List<DeckItem> deckItems;
}