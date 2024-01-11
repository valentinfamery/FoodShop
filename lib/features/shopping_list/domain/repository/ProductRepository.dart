import 'package:meal_maven/features/shopping_list/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> searchProductByName(String name);
}
