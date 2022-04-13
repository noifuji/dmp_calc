import '../../model/deck_item.dart';
import '../../model/inventory_item.dart';
import '../../assets/constants.dart' as constants;

class CalcAccountAssetValueUseCase {
  double call(Map<String, int> assets) {
    return constants.accountAssetNames.fold<double>(0.0, (prev, e) {
      int? quantity = assets[e];
      double? unit = constants.accountAssetsInDmp[e];
      if (quantity == null || unit == null) {
        return prev;
      }

      return prev + quantity * unit;
    });
  }

}

