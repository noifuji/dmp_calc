
import 'package:dmp_calc/view/widget/required_card_list_widget.dart';
import 'package:dmp_calc/view/widget/required_card_widget.dart';
import 'package:dmp_calc/view/widget/required_card_expansion_list_widget.dart';
import 'package:dmp_calc/view/widget/total_dmp_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/deck_item.dart';
import '../viewmodel/deck_cost_viewmodel.dart';
import 'widget/deck_url_input_widget.dart';
import '../assets/constants.dart' as constants;

class DeckCostScreen extends StatelessWidget {
  bool isDesktop = false;

  DeckCostScreen({Key? key, required this.isDesktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: TotalDmpWidget()),
        ),
        Expanded(
            flex: 5,
            child: Row(children: [
              Expanded(
                flex: 1,
                child: RequiredCardListWidget()
              ),
              const VerticalDivider(
                thickness: 3,
              ),

              /*--------------------Desktop Only----------------------*/
              Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: !isDesktop
                      ? const SizedBox.shrink()
                      : RequiredCardExpansionListWidget())
              /*------------------------------------------*/
            ])),
        Expanded(
          flex: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DeckUrlInputWidget()),
        ),
      ],
    );
  }

}