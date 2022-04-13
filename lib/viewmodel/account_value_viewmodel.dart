import 'package:dmp_calc/domain/usecase/calc_acount_asset_value_usecase.dart';
import 'package:dmp_calc/domain/usecase/create_deck_usecase.dart';
import 'package:dmp_calc/domain/repository/deck_repository.dart';
import 'package:dmp_calc/domain/usecase/delete_duplicate_deck_items_usecase.dart';
import 'package:dmp_calc/exception/dmp_calc_exception.dart';
import 'package:dmp_calc/model/card_specs.dart';
import 'package:dmp_calc/model/repository/api/http_card_specs_api.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/in_memory_inventory_data_source.dart';
import 'package:dmp_calc/model/repository/datasource/remote_card_specs_data_source.dart';
import 'package:dmp_calc/model/repository/inventory_repository_impl.dart';
import 'package:flutter/material.dart';

import '../domain/usecase/calc_deck_items_cost_usecase.dart';
import '../domain/repository/card_specs_repository.dart';
import '../domain/repository/inventory_repository.dart';
import '../model/deck.dart';
import '../model/deck_item.dart';
import '../model/inventory_item.dart';
import '../model/repository/card_specs_repository_impl.dart';
import '../model/repository/datasource/in_memory_deck_data_source.dart';
import '../model/repository/deck_repository_impl.dart';
import '../assets/constants.dart' as constants;

class AccountValueViewModel extends ChangeNotifier {

  double _totalValue = 0;
  final Map<String, int> _assets = {};


  AccountValueViewModel() {
    for (String element in constants.accountAssetNames) {
      _assets.addAll(<String, int>{element: 0});
    }

  }

  Map<String, int> get assets => _assets;

  double get totalValue => _totalValue;

  void updateAccountAssetsQuantity(String key, int quantity)  {
    _assets[key] = quantity;
    final calcAccountAssets = CalcAccountAssetValueUseCase();
    _totalValue = calcAccountAssets(_assets);
    notifyListeners();
  }


}