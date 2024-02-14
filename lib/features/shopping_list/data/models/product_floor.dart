import 'package:floor/floor.dart';

@entity
class Product {
  @primaryKey
  final int? barcodeId;

  final String? name;
  final String? imageFrontUrl;

  Product(
    this.barcodeId,
    this.name,
    this.imageFrontUrl,
  );
}
