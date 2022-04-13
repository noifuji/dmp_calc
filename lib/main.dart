import 'package:dmp_calc/view/account_value_screen.dart';
import 'package:dmp_calc/view/required_card_expansion_list_screen.dart';
import 'package:dmp_calc/view/required_card_list_screen.dart';
import 'package:dmp_calc/viewmodel/account_value_viewmodel.dart';
import 'package:dmp_calc/viewmodel/deck_cost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './assets/constants.dart' as constants;

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

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  DeckCostViewModel _deckCostViewModel = DeckCostViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
        _deckCostViewModel.init(),
    builder: (context, dataSnapshot) {
    if (dataSnapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    } else if (dataSnapshot.error != null) {
    return MaterialApp(
      title: 'デュエプレ計算ツール',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const Text('エラー。再ロードしてね。', style: TextStyle(fontFamily: constants.appFont,))
    );


    } else {
    return MultiProvider(providers: [
        ChangeNotifierProvider.value(value: _deckCostViewModel),
        ChangeNotifierProvider.value(value: AccountValueViewModel()),
    ], child: MaterialApp(
      title: 'デュエプレ計算ツール',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'デュエプレ計算ツール'),
    ));}});
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

  static final List<Widget> _widgetOptions = <Widget>[
    RequiredCardListScreen(),
    RequiredCardExpansionListScreen(),
    AccountValueScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デュエプレ計算ツール', style: TextStyle(fontFamily: constants.appFont),),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.style), label: 'デッキコスト(カード別)'),
          BottomNavigationBarItem(
              icon: Icon(Icons.style), label: 'デッキコスト(パック別)'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント価値')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
