import 'dart:math';

import 'package:dmp_calc/exception/dmp_calc_exception.dart';
import 'package:dmp_calc/view/required_card.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;
import '../model/deck_item.dart';

class RequiredCardListScreen extends StatefulWidget {
  RequiredCardListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RequiredCardListScreenState();
}

class _RequiredCardListScreenState extends State<RequiredCardListScreen> {
  final fieldText = TextEditingController();

  List<Widget> getChipsAndTextField(BuildContext context) {
    List<Widget> list = <Widget>[];
    list.addAll(Provider.of<DeckCostViewModel>(context)
        .decks
        .map(
          (e) => Chip(
              label: Text(e.name, style: TextStyle(fontFamily: constants.appFont,)),
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
                content: Text(e.message, style: TextStyle(fontFamily: constants.appFont,)),
              ));
            }
          },
        ));
    list.add(tf);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<DeckItem> deckItems =
        Provider.of<DeckCostViewModel>(context, listen: false).uniqueDecksItems;
    List<RequiredCard> _requiredCards =
        deckItems.map((e) => RequiredCard(deckItem: e)).toList();

    final formatter = NumberFormat("#,###");

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.secondary.withAlpha(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Row(children: <Widget>[
                        const Expanded(
                          flex: 1,
                          child: Text('トータル要求DMP',
                              style: TextStyle(fontSize: 15.0,
                                fontFamily: constants.appFont,)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              formatter.format(
                                  Provider.of<DeckCostViewModel>(context)
                                      .totalCost),
                              style: const TextStyle(fontSize: 32.0,
                                fontFamily: constants.appFont,)),
                        )
                      ]),
                    ),
                  ),
                ),
              ])),
        ),
        Expanded(
          flex: 5,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 25.0),
                    child: const Text(
                      'コスト',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: constants.appFont,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: const Text(
                      'カード名',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: constants.appFont,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: const Text(
                      '必要数',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: constants.appFont,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: const Text(
                      '所持数',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: constants.appFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _requiredCards.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) =>
                      _requiredCards[index],
                ),
              ]),
            )),
          ]),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
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
            ),
          ),
        ),
      ],
    );
  }
}
