import 'package:floor/floor.dart';

@entity
class ProductFoodShop {
  @primaryKey
  final int? barcodeId;

  final String? name;
  final bool? isSaved;
  final String? imageFrontUrl;
  final bool? isBuy;
  final String? weight;
  final int? quantity;

  ProductFoodShop(this.barcodeId, this.name, this.isSaved, this.imageFrontUrl,
      this.isBuy, this.weight,this.quantity);
}
