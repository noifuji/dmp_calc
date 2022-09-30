import 'package:dmp_calc/model/inventory_item.dart';
import 'package:dmp_calc/view/widget/required_card_expansion_list_widget.dart';
import 'package:dmp_calc/view/widget/deck_url_input_widget.dart';
import 'package:dmp_calc/view/widget/total_dmp_widget.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;
import '../exception/dmp_calc_exception.dart';
import '../model/deck_item.dart';

class DeckCostExpansionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 0,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: TotalDmpWidget()
            )),
        Expanded(
          flex: 5,
          child: RequiredCardExpansionListWidget()
        ),
        Expanded(
          flex: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DeckUrlInputWidget()
          ),
        ),
      ],
    );
  }
}
