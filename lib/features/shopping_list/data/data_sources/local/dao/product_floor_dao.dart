import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';

@dao
abstract class ProductFloorDao {
  @Query('SELECT * FROM Product')
  Stream<List<Product>> getAllProductFloor();

  @Query('SELECT * FROM Product WHERE barcodeId = :barcodeId')
  Future<Product?> getProductFloorById(int barcodeId);

  @insert
  Future<void> insertProductFloor(Product productFloor);

  @delete
  Future<void> deleteProductFloor(Product productFloor);
}
