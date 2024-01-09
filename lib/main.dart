import 'package:flutter/material.dart';
import 'package:meal_maven/config/routes/routes.dart';
import 'package:meal_maven/config/theme/app_theme.dart';
import 'package:meal_maven/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/ProductEntity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() async {
  runApp(const MainApp());

  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'meal_maven',
  );

  ProductRepository productRepository = ProductRepositoryImpl();

  final List<ProductEntity?>? list =
      await productRepository.searchProductByName('Nutella');

  for (var element in list!) {
    print(element!.name.toString());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      routerConfig: Routes.router,
    );
  }
}
