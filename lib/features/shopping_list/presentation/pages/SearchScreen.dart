import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/ListTag.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:go_router/go_router.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:food_shop/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final listSearchProductProvider =
    StateProvider<List<ProductFoodShop>>((ref) => []);

final buttonTagProvider = StateProvider<String>((ref) => 'Categories');

class SearchScreen extends ConsumerWidget {
  final myController = TextEditingController();

  final textFieldBrand = TextEditingController();
  final textFieldStores = TextEditingController();
  final textFieldIngredients = TextEditingController();

  var productRepository = sl<ProductRepository>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductFoodShop> listSearchProduct =
        ref.watch(listSearchProductProvider);

    String buttonTag = ref.watch(buttonTagProvider);

    PnnsGroup2? pnnsGroup2 = ref.watch(selectedPnnsGroup2);

    final country = ref.watch(countryStateProvider);

    final width = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            controller: myController,
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
                  myController.text,
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: listSearchProduct.length,
              itemBuilder: (BuildContext contextItem, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/search/details',
                          extra: listSearchProduct[index]);
                    },
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${listSearchProduct[index].name}',
                          style: TextStyle(fontSize: width * 0.07),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: width * 0.50,
                          width: width * 0.50,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: listSearchProduct[index].imageFrontUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchProductByName(String name, PnnsGroup2? pnnsGroup2, WidgetRef ref,
      String termBrand, String termStore, String termIngredient, OpenFoodFactsCountry country) async {
    final listAPI = await productRepository.searchProductByName(
        name, pnnsGroup2, termBrand, termStore, termIngredient,country);
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
        return ListTag();
      },
    );
  }
}
