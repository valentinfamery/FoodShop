import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKey = 'selected_language';

final sharedPrefs = sl<SharedPreferences>();

int? selectedLanguage = sharedPrefs.getInt(prefKey);

final languageProvider = StateProvider<OpenFoodFactsLanguage?>((ref) =>
    selectedLanguage != null
        ? OpenFoodFactsLanguage.values[selectedLanguage!]
        : null);
