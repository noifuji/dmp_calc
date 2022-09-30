

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exception/dmp_calc_exception.dart';
import '../../viewmodel/deck_cost_viewmodel.dart';
import '../../assets/constants.dart' as constants;

class DeckUrlInputWidget extends StatelessWidget {
  final fieldText = TextEditingController();

  DeckUrlInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color:
              Theme.of(context).colorScheme.secondary.withAlpha(50),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Wrap(
                  children: getChipsAndTextField(context),
                )),
          ),
        ),
      ],
    );
  }

  List<Widget> getChipsAndTextField(BuildContext context) {
    List<Widget> list = <Widget>[];
    list.addAll(Provider.of<DeckCostViewModel>(context)
        .decks
        .map(
          (e) => Chip(
          label: Text(e.name, style: const TextStyle(fontFamily: constants.appFont,)),
          deleteIcon: const Icon(
            Icons.close,
          ),
          onDeleted: () async {
            await Provider.of<DeckCostViewModel>(context, listen: false)
                .deleteDeck(e.id);
          }),
    )
        .toList());

    Widget tf = Container(
        width: 150,
        height: 30,
        child: TextField(
          controller: fieldText,
          decoration: const InputDecoration(hintText: 'デッキURLを貼付'),
          onChanged: (text) async {
            fieldText.clear();
            try {
              await Provider.of<DeckCostViewModel>(context, listen: false)
                  .addDeck(text);
            } on DmpCalcException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.message, style: const TextStyle(fontFamily: constants.appFont,)),
              ));
            }
          },
        ));
    list.add(tf);

    return list;
  }

}