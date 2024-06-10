import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_language_settings.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = sl<SharedPreferences>();

int? language = sharedPrefs.getInt('selected_language');

int? country = sharedPrefs.getInt('selected_country');

class ParametersScreen extends ConsumerWidget {
  const ParametersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ButtonCountrySettings(
                title: "Pays de Recherche",
                description: "Change le pays",
              ),
              const ButtonLanguageSettings(
                title: "Langue",
                description: "Change le langage de l'application",
              ),
              FilledButton(
                onPressed: () {
                  GoRouter.of(context).go('/list');
                },
                child: const Text('Suivant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
