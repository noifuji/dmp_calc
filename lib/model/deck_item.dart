import 'package:dmp_calc/model/card_specs.dart';

class DeckItem {
  CardSpecs card;
  int quantity;
  ZoneType zone;

  DeckItem({required this.card, required this.quantity, required this.zone});
}

enum ZoneType {
  chojigen,main
}