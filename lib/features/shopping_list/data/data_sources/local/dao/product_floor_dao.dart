import 'package:floor/floor.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM ProductFoodShop')
  Stream<List<ProductFoodShop>> getAllProductFloor();

  @Query('SELECT * FROM ProductFoodShop WHERE barcodeId = :barcodeId')
  Future<ProductFoodShop?> getProductFloorById(int barcodeId);

  @Query('SELECT * FROM ProductFoodShop WHERE barcodeId = :barcodeId')
  Stream<ProductFoodShop?> getStreamProductFloorById(int barcodeId);

  @insert
  Future<void> insertProductFloor(ProductFoodShop productFloor);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateProductFloor(ProductFoodShop productFloor);

  @delete
  Future<void> deleteProductFloor(ProductFoodShop productFloor);

  @Query('DELETE FROM ProductFoodShop')
  Future<void> deleteProducts();
}
