import 'package:floor/floor.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM ProductFloor')
  Future<List<ProductFloor>> getAllProductFloor();

  @Query('SELECT * FROM ProductFloor WHERE id = :id')
  Future<ProductFloor?> getProductFloorById(int id);

  @insert
  Future<void> insertProductFloor(ProductFloor productFloor);
}
