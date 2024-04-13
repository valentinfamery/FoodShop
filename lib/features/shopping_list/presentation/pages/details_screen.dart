import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/utils/languages.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/change_quantity.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';

final productSavedWithIdProvider =
    StreamProvider.autoDispose.family<ProductFoodShop?, int>((ref, id) {
  var productRepository = sl<ProductRepository>();

  return productRepository.getProductSavedWithId(id);
});

/// The details screen for either the A, B or C screen.
class DetailsScreen extends ConsumerWidget {
  final ProductFoodShop? productEntity;

  DetailsScreen({
    this.productEntity,
    super.key,
  });

  /// The label to display in the center of the screen.

  /// Constructs a [DetailsScreen].

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    final pastScreen =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    if (kDebugMode) {
      print(pastScreen.toString());
    }

    final product =
        ref.watch(productSavedWithIdProvider(productEntity!.barcodeId!));

    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return product.when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Details Screen'),
        ),
        body: Center(
          child: SizedBox(
            width: width * 0.80,
            child: Column(
              children: [
                Text(
                  productEntity?.nameLanguages?[selectedLanguage] ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(productEntity?.stores ?? ''),
                ChangeQuantity(productIdBarcode: productEntity!.barcodeId!),
                SizedBox(
                  height: width * 0.80,
                  width: width * 0.80,
                  child: productEntity?.imageFrontUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: productEntity!.imageFrontUrl!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : const Text('Non disponible'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (data == null) {
              productRepository.insertProductInFloor(productEntity!);
            } else {
              productRepository.deleteProductFloor(productEntity!);
            }
          },
          child: data != null ? const Icon(Icons.done) : const Icon(Icons.add),
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (error, staktrace) {
      return Text(error.toString());
    });
  }
}
