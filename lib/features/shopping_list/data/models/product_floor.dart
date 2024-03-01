import 'package:floor/floor.dart';

@entity
class Product {
  @primaryKey
  final int? barcodeId;

  final String? name;
  final bool? isSaved;
  final String? imageFrontUrl;
  final bool? buy;
  final String? quantity;

  Product(
    this.barcodeId,
    this.name,
    this.isSaved,
    this.imageFrontUrl,
    this.buy,
    this.quantity
  );
}
