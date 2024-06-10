import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/utils/languages.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const languages = OpenFoodFactsLanguage.values;

    final language = ref.watch(languageProvider);

    const String prefKey = 'selected_language';

    final sharedPrefs = sl<SharedPreferences>();

    saveCountry(int indexCountry) async {
      await sharedPrefs.setInt(prefKey, indexCountry);
    }

    return AlertDialog(
      title: const Text("Langage"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return RadioListTile<OpenFoodFactsLanguage>(
                  title: Text(languages[index].name),
                  value: languages[index],
                  groupValue: language,
                  onChanged: (OpenFoodFactsLanguage? value) {
                    ref
                        .read(languageProvider.notifier)
                        .update((state) => languages[index]);

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
