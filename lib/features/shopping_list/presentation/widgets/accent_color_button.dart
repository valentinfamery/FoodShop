import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/theme/app_theme.dart';
import 'package:food_shop/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccentColorButton extends ConsumerWidget {
  final Color color;

  const AccentColorButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acProvider = ref.watch(accentColorProvider);
    double size = 32;

    final sharedPreferences = sl<SharedPreferences>();

    Color _selectedColor = Color(00);

    // Key for SharedPreferences
    const String prefKey = 'selected_color';

    _saveColor(Color color) async {
      await sharedPreferences.setInt(prefKey, color.value);
    }

    return InkWell(
      onTap: () {
        _saveColor(color);
        ref.read(accentColorProvider.notifier).update((state) => color);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: size * .1,
            color: acProvider == color ? color : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(size),
        ),
        padding: EdgeInsets.all(size * .15),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size),
          ),
        ),
      ),
    );
  }
}
