import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_language_settings.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/row_clickable_settings_button.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/support_me_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight;

    return Scaffold(
      body: Container(
        height: height,
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.075,
              ),
              const RowClickableSettingsButton(
                  title: "Couleur d'accentuation",
                  description: "Change la couleur d'accentuation."),
              const ButtonCountrySettings(
                title: "Pays de Recherche",
                description: "Change le pays",
              ),
              const ButtonLanguageSettings(
                title: "Langue",
                description: "Change le langage de l'application",
              ),
              const SupportMeButton(
                title: 'Dons',
                description: 'Si vous souhaitez me soutenir cliquez ici',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
