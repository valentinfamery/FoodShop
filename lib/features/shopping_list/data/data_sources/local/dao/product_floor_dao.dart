import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM Product')
  Stream<List<ProductFoodShop>> getAllProductFloor();

  @Query('SELECT * FROM Product WHERE barcodeId = :barcodeId')
  Future<ProductFoodShop?> getProductFloorById(int barcodeId);

  @insert
  Future<void> insertProductFloor(ProductFoodShop productFloor);

  @delete
  Future<void> deleteProductFloor(ProductFoodShop productFloor);
}
