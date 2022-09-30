import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../assets/constants.dart' as constants;

class RequiredCardExpansionListWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Map<String, int> expansions =  Provider.of<DeckCostViewModel>(context).getCostByExpansion();

    final formatter = NumberFormat("#,###");

    return Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child:createExpansionListHeader()
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: <Widget>[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: expansions.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) => Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            child: Text(
                              expansions.keys.toList()[index],
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: constants.appFont,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20.0),
                            child: Text(
                              formatter.format(expansions[expansions.keys.toList()[index]]),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontFamily: constants.appFont,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )),
          ]);
  }


  Widget createExpansionListHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
            child: const Text(
              'エキスパンション名',
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
              '必要ポイント',
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
