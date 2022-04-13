import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/deck_item.dart';
import 'mana_symbol_icon.dart';

import '../assets/constants.dart' as constants;

class RequiredCard extends StatelessWidget {
  RequiredCard({
    required this.deckItem,
    Key? key,
  }) : super(key: key);

  final DeckItem deckItem;
  int _owned = 0;

  @override
  Widget build(BuildContext context) {
    try {
      _owned = Provider.of<DeckCostViewModel>(context, listen: false)
          .inventories
          .firstWhere((element) => element.card.id == deckItem.card.id)
          .quantity;
    } on StateError {
      _owned = 0;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: Container(
                margin:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: ManaSymbolIcon(
                    cost: deckItem.card.cost, color: deckItem.card.manaColor)),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                deckItem.card.name,
                style: const TextStyle(
                  fontSize: 16.0,
                    fontFamily: constants.appFont
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Text(
                deckItem.quantity.toString(),
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                    fontFamily: constants.appFont,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: DropdownButton(
                items: const <DropdownMenuItem<int>>[
                  DropdownMenuItem(
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 25.0,
                        fontFamily: constants.appFont,),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 25.0,
                        fontFamily: constants.appFont,),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 25.0,
                        fontFamily: constants.appFont,),
                    ),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '3',
                      style: TextStyle(fontSize: 25.0,
                        fontFamily: constants.appFont,),
                    ),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      '4',
                      style: TextStyle(fontSize: 25.0,
                        fontFamily: constants.appFont,),
                    ),
                    value: 4,
                  )
                ],
                value: _owned,
                onChanged: (value) async => {
                  await Provider.of<DeckCostViewModel>(context, listen: false)
                      .updateInventoryCardQuantity(
                      deckItem.card.id, int.parse(value.toString()))
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}