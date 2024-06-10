import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/list_tag.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/list.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/button_country_settings.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

final listSearchProductProvider =
    StateProvider<SearchState>((ref) => SearchState.empty());

final buttonTagProvider = StateProvider<String>((ref) => 'Categories');

final textFieldNameProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldBrandProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldStoresProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final textFieldIngredientsProvider = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));

final scanBarcodeProvider = StateProvider<String>((ref) => '');

enum SearchStateType { empty, loading, success }

class SearchState<T> {
  final SearchStateType type;
  final List<ProductFoodShop>? data;
  final Object? error;

  SearchState.empty()
      : type = SearchStateType.empty,
        data = [],
        error = null;

  SearchState.loading()
      : type = SearchStateType.loading,
        data = null,
        error = null;

  SearchState.success(this.data)
      : type = SearchStateType.success,
        error = null;
}

class SearchScreen extends ConsumerWidget {
  final productRepository = sl<ProductRepository>();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SearchState listSearchProduct = ref.watch(listSearchProductProvider);
    final textFieldName = ref.watch(textFieldNameProvider);
    final textFieldBrand = ref.watch(textFieldBrandProvider);
    final textFieldStores = ref.watch(textFieldStoresProvider);
    final textFieldIngredients = ref.watch(textFieldIngredientsProvider);
    String buttonTag = ref.watch(buttonTagProvider);
    PnnsGroup2? pnnsGroup2 = ref.watch(selectedPnnsGroup2);
    final country = ref.watch(countryStateProvider);
    final barcode = ref.watch(scanBarcodeProvider);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width * 0.9,
            height: height,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: textFieldName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Saisissez le Nom du Produit ',
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                TextField(
                  controller: TextEditingController(text: barcode),
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
                SizedBox(
                  height: height * 0.025,
                ),
                TextField(
                  controller: textFieldStores,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Saisissez le Magasin du Produit',
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                TextField(
                  controller: textFieldIngredients,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Saisissez un des ingredients du Produit',
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
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
                        country!);
                  },
                  child: const Text('Rechercher'),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                FilledButton(
                  onPressed: () {
                    showMyDialog(context);
                  },
                  child: Text(buttonTag),
                ),
                ElevatedButton(
                    onPressed: () => scanBarcodeNormal(ref),
                    child: const Text('Start barcode scan')),
                SizedBox(
                  height: height * 0.025,
                ),
                Expanded(
                  child: listSearchProduct.type == SearchStateType.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListWidget(products: listSearchProduct.data!),
                ),
              ],
            ),
          ),
        ),
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
    ref
        .read(listSearchProductProvider.notifier)
        .update((state) => SearchState.loading());

    final listAPI = await productRepository.searchProductByName(
        name, pnnsGroup2, termBrand, termStore, termIngredient, country);
    for (var element in listAPI) {
      if (kDebugMode) {
        print(element.nameLanguages![OpenFoodFactsLanguage.ENGLISH]);
      }
    }
    ref
        .read(listSearchProductProvider.notifier)
        .update((state) => SearchState.success(listAPI));
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

  Future<void> scanBarcodeNormal(WidgetRef ref) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (kDebugMode) {
        print(barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    ref.read(scanBarcodeProvider.notifier).update((state) => barcodeScanRes);
  }
}
