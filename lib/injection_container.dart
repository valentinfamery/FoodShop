import 'package:get_it/get_it.dart';
import 'package:meal_maven/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<ProductRepository>(
    ProductRepositoryImpl()
  );

}
