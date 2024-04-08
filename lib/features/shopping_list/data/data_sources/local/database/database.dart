import 'dart:async';
import 'package:floor/floor.dart';
import 'package:food_shop/config/utils/map_string_type_converter.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@TypeConverters([MapConverter])
@Database(version: 1, entities: [ProductFoodShop])
abstract class AppDatabase extends FloorDatabase {
  ProductFloorDao get productFloorDao;
}
