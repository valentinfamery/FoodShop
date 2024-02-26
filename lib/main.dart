import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_maven/config/routes/routes.dart';
import 'package:meal_maven/config/theme/app_theme.dart';
import 'package:meal_maven/features/shopping_list/data/data_sources/local/database/database.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const ProviderScope(
    child: MainApp(),
  ));

  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'meal_maven',
  );
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
