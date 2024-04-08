import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';

final productSavedWithIdProvider =
    StreamProvider.autoDispose.family<ProductFoodShop?, int>((ref, id) {
  var productRepository = sl<ProductRepository>();

  return productRepository.getProductSavedWithId(id);
});

class ChangeQuantity extends ConsumerWidget {
  int productIdBarcode;

  ChangeQuantity({super.key, required this.productIdBarcode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var productRepository = sl<ProductRepository>();

    final pastScreen =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    final product = ref.watch(productSavedWithIdProvider(productIdBarcode));

    return product.when(data: (product) {
      return Row(
        children: [
          pastScreen == '/list/details'
              ? InkWell(
                  onTap: () {
                    if (product!.quantity! > 1) {
                      final quantityRemove = product.quantity! - 1;

                      final updateProduct = ProductFoodShop(
                          product.barcodeId,
                          product.name,
                          product.isSaved,
                          product.imageFrontUrl,
                          product.isBuy,
                          product.weight,
                          quantityRemove);

                      productRepository.updateProductFloor(updateProduct);
                    }
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.remove,
                    ),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          pastScreen == '/list/details'
              ? Text('${product!.quantity} x ${product!.weight}')
              : const SizedBox(),
          const Spacer(),
          pastScreen == '/list/details'
              ? InkWell(
                  onTap: () {
                    final quantityAdd = product!.quantity! + 1;

                    final updateProduct = ProductFoodShop(
                        product.barcodeId,
                        product.name,
                        product.isSaved,
                        product.imageFrontUrl,
                        product.isBuy,
                        product.weight,
                        quantityAdd);

                    productRepository.updateProductFloor(updateProduct);
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      );
    }, error: (err, stack) {
      return Text(err.toString());
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
