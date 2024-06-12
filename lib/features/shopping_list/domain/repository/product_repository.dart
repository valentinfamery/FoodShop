import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

abstract class ProductRepository {
  Future<List<ProductFoodShop>> searchProductByName(
      String name,
      PnnsGroup2? pnnsGroup2,
      String termBrand,
      String termStore,
      String termIngredient,
      String barcode,
      OpenFoodFactsCountry country, OpenFoodFactsLanguage language);

  void insertProductInFloor(ProductFoodShop product);

  Stream<List<ProductFoodShop>> getProductsSaved();

  Stream<ProductFoodShop?> getProductSavedWithId(int barcodeId);

  void updateProductFloor(ProductFoodShop product);

  void deleteProductFloor(ProductFoodShop product);

  void deleteProducts();
}
