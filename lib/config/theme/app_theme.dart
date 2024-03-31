import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKey = 'selected_color';

final sharedPrefs = sl<SharedPreferences>();

int? color = sharedPrefs.getInt(prefKey);

final accentColorProvider =
    StateProvider<Color>((ref) => color != null ? Color(color!) : Colors.blue);
