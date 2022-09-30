import 'package:dmp_calc/view/widget/required_card_widget.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../assets/constants.dart' as constants;
import '../../model/deck_item.dart';
import '../../model/deck_item.dart';

class RequiredCardListWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    List<DeckItem> deckItems =
        Provider.of<DeckCostViewModel>(context).uniqueDecksItems;
    List<RequiredCardWidget> _requiredCards =
        deckItems.map((e) => RequiredCardWidget(deckItem: e)).toList();

    return Column(children: <Widget>[
                  createCardListHeader(),
                  Expanded(
                      child: SingleChildScrollView(
                    primary: false,
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
                ]);
  }

  Widget createCardListHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
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
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
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
    );
  }
}
