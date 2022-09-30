
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../assets/constants.dart' as constants;
import '../../viewmodel/deck_cost_viewmodel.dart';

class TotalDmpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return Row(children: <Widget>[
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
    ]);
  }

}