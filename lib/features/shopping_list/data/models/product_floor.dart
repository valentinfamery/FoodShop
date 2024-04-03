import 'package:floor/floor.dart';

@entity
class ProductFoodShop {
  @primaryKey
  final int? barcodeId;

  final String? name;
  final bool? isSaved;
  final String? imageFrontUrl;
  final bool? buy;
  final String? quantity;

  ProductFoodShop(this.barcodeId, this.name, this.isSaved, this.imageFrontUrl,
      this.buy, this.quantity);
}
