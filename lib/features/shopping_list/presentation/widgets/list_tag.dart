import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/pages/search_screen.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final selectedPnnsGroup2 = StateProvider<PnnsGroup2?>((ref) => null);

class ListTag extends ConsumerWidget {
  const ListTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valuePnnsGroup2 = ref.watch(selectedPnnsGroup2);

    List<PnnsGroup2> pnnsGroup2list = PnnsGroup2.values;

    return AlertDialog(
      title: const Text('Categories'),
      content: Column(
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
          SizedBox(
            width: 300,
            height: 400,
            child: ListView.builder(
                itemCount: pnnsGroup2list.length,
                itemBuilder: (context, index) {
                  return RadioListTile<PnnsGroup2?>(
                      title: Text(pnnsGroup2list[index].name),
                      value: pnnsGroup2list[index],
                      groupValue: valuePnnsGroup2,
                      onChanged: (PnnsGroup2? value) {
                        ref
                            .read(buttonTagProvider.notifier)
                            .update((state) => pnnsGroup2list[index].name);

                        ref
                            .read(selectedPnnsGroup2.notifier)
                            .update((state) => value);
                      });
                }),
          ),
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
