import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/accent_color_button.dart';
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccentColorButton(color: Color(0xFFE54C41)),
                AccentColorButton(color: Color(0xFFFFCD29)),
                AccentColorButton(color: Color(0xFF14AE5C)),
                AccentColorButton(color: Color(0xFF4C88EF)),
              ],
            )
        ],
      ),
    );
  }
}
