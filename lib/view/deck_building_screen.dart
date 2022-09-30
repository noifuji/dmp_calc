import 'package:dmp_calc/view/widget/total_dmp_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/constants.dart' as constants;

class DeckBuildingScreen extends StatelessWidget {
  DeckBuildingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: TotalDmpWidget()
          ),
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
          ]),
        ),
      ]
    );
  }

}