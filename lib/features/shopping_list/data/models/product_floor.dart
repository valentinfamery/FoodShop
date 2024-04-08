import 'package:floor/floor.dart';
import 'package:food_shop/config/utils/map_string_type_converter.dart';

import 'package:openfoodfacts/openfoodfacts.dart';

@entity
class ProductFoodShop {
  @primaryKey
  final int? barcodeId;

  final bool? isSaved;
  final String? imageFrontUrl;
  final bool? isBuy;
  final String? weight;
  final int? quantity;

  final Map<OpenFoodFactsLanguage, String>? nameLanguages;

  const ProductFoodShop(this.barcodeId, this.nameLanguages, this.isSaved,
      this.imageFrontUrl, this.isBuy, this.weight, this.quantity);
}
