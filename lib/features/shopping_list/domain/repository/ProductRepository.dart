import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

abstract class ProductRepository {
  Future<List<Product>> searchProductByName(String name);

  void insertProductInFloor(Product product);

  Stream<List<Product>> getProductsSaved();
}
