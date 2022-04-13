import 'package:dmp_calc/viewmodel/account_value_viewmodel.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../assets/constants.dart' as constants;

class AccountValueScreen extends StatefulWidget {
  const AccountValueScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountValueScreenScreenState();
}

class _AccountValueScreenScreenState extends State<AccountValueScreen> {
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Row(children: <Widget>[
                            const Expanded(
                              flex: 1,
                              child: Text('アカウント換算DMP',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: constants.appFont)),
                            ),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  formatter.format(
                                      Provider.of<AccountValueViewModel>(context).totalValue),
                                  style: const TextStyle(
                                      fontSize: 32.0,
                                      fontFamily: constants.appFont),
                                ))
                          ]),
                        ),
                      ),
                    ),
                  ])),
            ),
            Expanded(
              flex: 5,
              child: Column(children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: constants.accountAssetNames.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 20.0),
                                child: Text(
                                  constants.accountAssetNames[index],
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: constants.appFont),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 20.0),
                                child: TextFormField(
                                  initialValue: Provider.of<AccountValueViewModel>(
                                      context, listen: false).assets[constants.accountAssetNames[index]]==0? '':Provider.of<AccountValueViewModel>(
                                      context, listen: false).assets[constants.accountAssetNames[index]].toString(),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontFamily: constants.appFont),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  autofocus: index == 0,
                                  textInputAction: index < constants.accountAssetNames.length ? TextInputAction.next: TextInputAction.done,
                                  onChanged: (text) {
                                    if(text == '') {
                                      return;
                                    }

                                    int quantity = 0;
                                    try {
                                      quantity = int.parse(text);

                                      Provider.of<AccountValueViewModel>(
                                          context, listen: false)
                                          .updateAccountAssetsQuantity(
                                          constants.accountAssetNames[index],
                                          quantity);

                                    } on FormatException {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('数字を入力してね。',style: TextStyle(fontFamily: constants.appFont,)),
                                      ));
                                    }

                                  }
                                  ,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Text('${expansions[index]} :  ${expansionsDmp[index]}'),
                    ),
                  ]),
                )),
              ]),
            ),
          ],
        );
  }
}
