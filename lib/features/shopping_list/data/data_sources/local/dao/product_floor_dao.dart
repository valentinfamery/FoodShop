import 'package:floor/floor.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM ProductFloor')
  Future<List<Product>> getAllProductFloor();

  @Query('SELECT * FROM ProductFloor WHERE id = :id')
  Future<Product?> getProductFloorById(int id);

  @insert
  Future<void> insertProductFloor(Product productFloor);
}
