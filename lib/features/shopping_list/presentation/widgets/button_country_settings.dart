import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/country_dialog.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKey = 'selected_country';

final sharedPrefs = sl<SharedPreferences>();

int? country = sharedPrefs.getInt(prefKey);

final countryStateProvider = StateProvider<OpenFoodFactsCountry>((ref) =>
    country != null
        ? OpenFoodFactsCountry.values[country!]
        : OpenFoodFactsCountry.FRANCE);

class ButtonCountrySettings extends ConsumerWidget {
  final String title;
  final String description;

  ButtonCountrySettings({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(countryStateProvider);

    double size = 32;

    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        showMyDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: Text(country.name),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CountryDialog();
      },
    );
  }
}
