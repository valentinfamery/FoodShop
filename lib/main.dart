import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/routes/routes.dart';
import 'package:food_shop/config/theme/app_theme.dart';
import 'package:food_shop/injection_container.dart';
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

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: ref.watch(accentColorProvider)),
      ),
      routerConfig: Routes.router,
    );
  }
}
