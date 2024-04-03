import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/accent_color_button.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/row_clickable_settings_button.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

enum ColorPossibility { Rouge, Jaune, Vert, Bleu }

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ColorPossibility colorPossibility = ColorPossibility.Bleu;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RowClickableSettingsButton(
                title: "Couleur d'accentuation",
                description: "Change la couleur d'accentuation.")
          ],
        ),
      ),
    );
  }
}
