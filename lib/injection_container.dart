import 'package:get_it/get_it.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/local/database/database.dart';
import 'package:food_shop/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:food_shop/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl(database.productFloorDao));

  sl.registerSingleton<SharedPreferences>(prefs);
}
