import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/list_tag.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/list.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final listSearchProductProvider =
    StateProvider<List<ProductFoodShop>>((ref) => []);

final buttonTagProvider = StateProvider<String>((ref) => 'Categories');

final textFieldNameProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldBrandProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldStoresProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldIngredientsProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));

class SearchScreen extends ConsumerWidget {
  var productRepository = sl<ProductRepository>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductFoodShop> listSearchProduct =
        ref.watch(listSearchProductProvider);
    final textFieldName = ref.watch(textFieldNameProvider);
    final textFieldBrand = ref.watch(textFieldBrandProvider);
    final textFieldStores = ref.watch(textFieldStoresProvider);
    final textFieldIngredients = ref.watch(textFieldIngredientsProvider);
    String buttonTag = ref.watch(buttonTagProvider);
    PnnsGroup2? pnnsGroup2 = ref.watch(selectedPnnsGroup2);
    final country = ref.watch(countryStateProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textFieldName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Saisissez le Nom du Produit ',
            ),
          ),
          TextField(
            controller: textFieldBrand,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Saisissez la Marque du Produit',
            ),
          ),
          TextField(
            controller: textFieldStores,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Saisissez le Magasin du Produit',
            ),
          ),
          TextField(
            controller: textFieldIngredients,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Saisissez un des ingredients du Produit',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              searchProductByName(
                  textFieldName.text,
                  pnnsGroup2,
                  ref,
                  textFieldBrand.text,
                  textFieldStores.text,
                  textFieldIngredients.text,
                  country);
            },
            child: const Text('Search'),
          ),
          FilledButton(
            onPressed: () {
              showMyDialog(context);
            },
            child: Text(buttonTag),
          ),
          Expanded(
            child: ListWidget(products: listSearchProduct),
          ),
        ],
      ),
    );
  }

  void searchProductByName(
      String name,
      PnnsGroup2? pnnsGroup2,
      WidgetRef ref,
      String termBrand,
      String termStore,
      String termIngredient,
      OpenFoodFactsCountry country) async {
    final listAPI = await productRepository.searchProductByName(
        name, pnnsGroup2, termBrand, termStore, termIngredient, country);
    for (var element in listAPI) {
      if (kDebugMode) {
        print(element.name);
      }
    }
    ref.read(listSearchProductProvider.notifier).update((state) => listAPI);
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const ListTag();
      },
    );
  }
}
