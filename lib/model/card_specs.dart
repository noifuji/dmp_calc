class CardSpecs {
  CardSpecs(
      {required this.id,
      required this.name,
      required this.race,
      required this.type,
      required this.manaColor,
      required this.rarity,
      required this.cost,
      required this.power,
      required this.mana,
      required this.text,
      required this.flavor,
      required this.generateDmp,
      required this.convertDmp,
      required this.expansionCode,
      required this.secretFlag});

  final String id;
  final String name;
  final String race;
  final String type;
  final String manaColor;
  final String rarity;
  final int cost;
  final String power;
  final int mana;
  final String text;
  final String flavor;
  final int generateDmp;
  final int convertDmp;
  final String expansionCode;
  final bool secretFlag;
  String? originalCardId;
}
