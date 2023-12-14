import 'package:breakpoint/breakpoint.dart';
import 'package:dmp_calc/model/repository/api/http_psychic_relation_api.dart';
import 'package:dmp_calc/view/account_value_screen.dart';
import 'package:dmp_calc/view/deck_cost_expansion_screen.dart';
import 'package:dmp_calc/view/deck_cost_screen.dart';
import 'package:dmp_calc/viewmodel/account_value_viewmodel.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:url_strategy/url_strategy.dart';

import './assets/constants.dart' as constants;
import 'domain/repository/card_specs_repository.dart';
import 'domain/repository/deck_repository.dart';
import 'domain/repository/inventory_repository.dart';
import 'firebase_options.dart';
import 'model/inventory_item.dart';
import 'model/repository/api/http_card_specs_api.dart';
import 'model/repository/card_specs_repository_impl.dart';
import 'model/repository/datasource/in_memory_card_specs_data_source.dart';
import 'model/repository/datasource/in_memory_deck_data_source.dart';
import 'model/repository/datasource/in_memory_inventory_data_source.dart';
import 'model/repository/datasource/remote_card_specs_data_source.dart';
import 'model/repository/deck_repository_impl.dart';
import 'model/repository/inventory_repository_impl.dart';

/*
* 超次元クリチャーを表示する。
* 超次元呪文と超次元クリーチャーのひもつけを作成し、超次元クリーチャーの生成コストを表示する。
*
* */

Future<void> main() async {
  //Not to use hash for web app
  setPathUrlStrategy();

  //For google analytics
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

}

class MyAppState extends State<MyApp> {

  late DeckCostViewModel _deckCostViewModel;
  late AccountValueViewModel _accountValueViewModel;
  late Future<bool> init;

  @override
  void initState() {
    init = initializeApp();
  }

  Future<bool> initializeApp() async {
    DeckRepository _deckRepository = DeckRepositoryImpl(InMemoryDeckDataSource());
    InventoryRepository _inventoryRepository = InventoryRepositoryImpl(InMemoryInventoryDataSource());
    CardSpecsRepository _cardSpecsRepository = CardSpecsRepositoryImpl(RemoteCardSpecsDataSource(HttpCardSpecsApi(), HttpPsychicRelationApi()), InMemoryCardSpecsDataSource());

    await _inventoryRepository.insertBulk((await _cardSpecsRepository.getAll()).map((e) => InventoryItem(card: e,quantity: 0)).toList());

    _deckCostViewModel = DeckCostViewModel(_deckRepository, _inventoryRepository, _cardSpecsRepository);
    _accountValueViewModel = AccountValueViewModel();

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if (dataSnapshot.hasError) {
            return MaterialApp(
                title: 'デュエプレ計算ツール',
                theme: ThemeData(
                  brightness: Brightness.light,
                ),
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                ),
                themeMode: ThemeMode.dark,
                home: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                  const Text('エラー。再ロードしてね。',
                    style: TextStyle(
                      fontFamily: constants.appFont,
                    )),
                      Text(dataSnapshot.error.toString(), style: TextStyle(fontSize:15),),
                  Text(dataSnapshot.stackTrace.toString(), style: TextStyle(fontSize:15),),
          ]));
          } else {
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: _deckCostViewModel),
                  ChangeNotifierProvider.value(value: _accountValueViewModel),
                ],
                child: MaterialApp(
                  title: 'デュエプレ計算ツール(LOP2024対応)',
                  theme: ThemeData(
                    brightness: Brightness.light,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                  ),
                  themeMode: ThemeMode.dark,
                  home: const MyHomePage(title: 'デュエプレ計算ツール(LOP2024対応)'),
                ));
          }
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

   final List<Widget> _widgetOptionsForMobile = <Widget>[

  ];

   final List<Widget> _widgetOptionsForDesktop = <Widget>[
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final _breakpoint = Breakpoint.fromConstraints(constraints);
      int _columns = _breakpoint.columns;

      if(_columns > 4) {
        _widgetOptionsForDesktop.add(DeckCostScreen(isDesktop: true,));
        _widgetOptionsForDesktop.add(AccountValueScreen());
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: const TextStyle(fontFamily: constants.appFont),
            ),
          ),
          body: Row(children:[
            SideNavigationBar(
              selectedIndex: _selectedIndex,
              items: const [
                SideNavigationBarItem(
                  icon: Icons.style, label: 'デッキコスト'
                ),
                SideNavigationBarItem(
                  icon: Icons.person, label: 'アカウント価値'
                ),
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: _widgetOptionsForDesktop.elementAt(_selectedIndex),
            )
          ]),
        );
      } else {
        _widgetOptionsForMobile.add(DeckCostScreen(isDesktop: false,));
        _widgetOptionsForMobile.add(DeckCostExpansionScreen());
        _widgetOptionsForMobile.add(AccountValueScreen());
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'デュエプレ計算ツール',
            style: TextStyle(fontFamily: constants.appFont),
          ),
        ),
        body: Center(
          child: _widgetOptionsForMobile.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.style), label: 'DMP(カード別)'),
            BottomNavigationBarItem(
                icon: Icon(Icons.style), label: 'DMP(パック別)'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント価値')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
      }
    });
  }
}
