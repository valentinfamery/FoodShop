import 'package:meal_maven/features/shopping_list/domain/entities/ProductEntity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> searchProductByName(String name);
}
