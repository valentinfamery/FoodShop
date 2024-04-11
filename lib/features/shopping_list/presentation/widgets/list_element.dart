import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/config/utils/languages.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final productSavedWithIdProvider =
    StreamProvider.autoDispose.family<ProductFoodShop?, int>((ref, id) {
  var productRepository = sl<ProductRepository>();

  return productRepository.getProductSavedWithId(id);
});

class GridElement extends ConsumerWidget {
  final ProductFoodShop product;

  const GridElement({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final productFollowUpdate = ref.watch(productSavedWithIdProvider(product.barcodeId!));

    var productRepository = sl<ProductRepository>();

    final pastScreen =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final height = MediaQuery.of(context).size.height * 0.10;
    final width = MediaQuery.of(context).size.width * 0.90;

    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return InkWell(
      onTap: () {
        if (pastScreen == '/list') {
          GoRouter.of(context).go('/list/details', extra: product);
        } else if (pastScreen == '/search') {
          GoRouter.of(context).go('/search/details', extra: product);
        }
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: height,
            width: height,
            child: product.imageFrontUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.imageFrontUrl!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : const Center(child: Text('Non disponible')),
          ),
          const Spacer(),
          SizedBox(
            width: width * 0.50,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.50,
                  height: height * 0.50,
                  child: Text(
                    product.nameLanguages![selectedLanguage] ?? '',
                    style: TextStyle(
                        fontSize: height * 0.20,
                        decoration: product.isBuy!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: width * 0.50,
                  height: height * 0.50,
                  child: Text(
                    '${product.quantity} x ${product.weight}',
                    style: TextStyle(
                      fontSize: height * 0.20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          pastScreen == '/list'
              ? SizedBox(
                  height: height,
                  width: width * 0.20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Checkbox(
                      value: product.isBuy!,
                      onChanged: (bool? value) {
                        //ref.read(checkboxStateProvider.notifier).update((state) => value!);

                        final updateProduct = ProductFoodShop(
                            product.barcodeId,
                            product.nameLanguages,
                            product.imageFrontUrl,
                            value!,
                            product.weight,
                            product.quantity,product.stores);

                        productRepository.updateProductFloor(updateProduct);
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: height,
                  width: width * 0.20,
                ),
        ],
      ),
    );
  }
}
