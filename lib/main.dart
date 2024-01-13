import 'package:flutter/material.dart';
import 'package:meal_maven/config/routes/routes.dart';
import 'package:meal_maven/config/theme/app_theme.dart';
import 'package:meal_maven/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());

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
