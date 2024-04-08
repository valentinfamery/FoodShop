import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class MapConverter
    extends TypeConverter<Map<OpenFoodFactsLanguage, String>?, String?> {
  @override
  Map<OpenFoodFactsLanguage, String>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(databaseValue);
    return map.map((key, value) => MapEntry(
        OpenFoodFactsLanguage.values.firstWhere((l) => l.name == key), value));
  }

  @override
  String? encode(Map<OpenFoodFactsLanguage, String>? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value.map((key, value) => MapEntry(key.name, value)));
  }
}
