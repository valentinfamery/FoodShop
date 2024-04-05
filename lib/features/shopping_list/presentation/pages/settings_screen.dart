import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/row_clickable_settings_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Mes Paramètres'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RowClickableSettingsButton(
                title: "Couleur d'accentuation",
                description: "Change la couleur d'accentuation."),
            ButtonCountrySettings(
              title: "Pays de Recherche",
              description: "Change le pays",
            ),
          ],
        ),
      ),
    );
  }
}
