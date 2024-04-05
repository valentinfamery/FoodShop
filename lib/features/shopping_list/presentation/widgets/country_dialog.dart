import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryDialog extends ConsumerWidget {
  const CountryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const listCountry = OpenFoodFactsCountry.values;

    final country = ref.watch(countryStateProvider);

    const String prefKey = 'selected_country';

    final sharedPrefs = sl<SharedPreferences>();

    saveCountry(int indexCountry) async {
      await sharedPrefs.setInt(prefKey, indexCountry);
    }

    return AlertDialog(
      title: const Text("Pays"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: ListView.builder(
            itemCount: listCountry.length,
            itemBuilder: (context, index) {
              return RadioListTile<OpenFoodFactsCountry>(
                  title: Text(listCountry[index].name),
                  value: listCountry[index],
                  groupValue: country,
                  onChanged: (OpenFoodFactsCountry? value) {
                    ref
                        .read(countryStateProvider.notifier)
                        .update((state) => listCountry[index]);

                    saveCountry(index);
                  });
            }),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Confirmer'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
