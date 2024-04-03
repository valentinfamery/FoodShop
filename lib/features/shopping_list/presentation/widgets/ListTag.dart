import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/SearchScreen.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final selectedPnnsGroup2 = StateProvider<PnnsGroup2?>((ref) => null);

class ListTag extends ConsumerWidget {
  ListTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valuePnnsGroup2 = ref.watch(selectedPnnsGroup2);

    return AlertDialog(
      title: const Text('Categories'),
      content: ListView(
        children: [
          RadioListTile<PnnsGroup2?>(
              title: const Text('Toutes les categories'),
              value: null,
              groupValue: valuePnnsGroup2,
              onChanged: (PnnsGroup2? value) {
                ref
                    .read(buttonTagProvider.notifier)
                    .update((state) => 'Categories');
                ref.read(selectedPnnsGroup2.notifier).update((state) => value);
              }),
          RadioListTile<PnnsGroup2?>(
              title: Text(PnnsGroup2.ALCOHOLIC_BEVERAGES.name),
              value: PnnsGroup2.ALCOHOLIC_BEVERAGES,
              groupValue: valuePnnsGroup2,
              onChanged: (PnnsGroup2? value) {
                ref
                    .read(buttonTagProvider.notifier)
                    .update((state) => PnnsGroup2.ALCOHOLIC_BEVERAGES.name);

                ref.read(selectedPnnsGroup2.notifier).update((state) => value);
              }),
          RadioListTile<PnnsGroup2?>(
              title: Text(PnnsGroup2.APPETIZERS.name),
              value: PnnsGroup2.APPETIZERS,
              groupValue: valuePnnsGroup2,
              onChanged: (PnnsGroup2? value) {
                ref
                    .read(buttonTagProvider.notifier)
                    .update((state) => PnnsGroup2.APPETIZERS.name);

                ref.read(selectedPnnsGroup2.notifier).update((state) => value);
              }),
        ],
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
