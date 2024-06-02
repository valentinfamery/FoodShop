import 'package:floor/floor.dart';

import 'package:openfoodfacts/openfoodfacts.dart';

@entity
class ProductFoodShop {
  @primaryKey
  final int? barcodeId;

  final String? imageFrontUrl;
  final bool? isBuy;
  final String? weight;
  final int? quantity;
  final String? stores;
  final String? countryOfSale;
  final String? origins;
  final String? nutrimentDataPer;
  final String? nutrimentEnergyUnit;
  final String? imageNutritionUrl;
  final String? ingredients;

  final Map<OpenFoodFactsLanguage, String>? nameLanguages;

  const ProductFoodShop(
      this.barcodeId,
      this.nameLanguages,
      this.imageFrontUrl,
      this.isBuy,
      this.weight,
      this.quantity,
      this.stores,
      this.countryOfSale,
      this.ingredients,
      this.origins,
      this.nutrimentDataPer,
      this.nutrimentEnergyUnit,
      this.imageNutritionUrl);
}
