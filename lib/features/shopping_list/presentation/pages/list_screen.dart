import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/delete_list_dialog.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/list.dart';
import 'package:food_shop/injection_container.dart';

/// The third screen in the bottom navigation bar.

final getProductsSaved =
    StreamProvider.autoDispose<List<ProductFoodShop>?>((ref) {
  var productRepository = sl<ProductRepository>();

  return productRepository.getProductsSaved();
});

// ignore: must_be_immutable
class ListScreen extends ConsumerWidget {
  var productRepository = sl<ProductRepository>();

  ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(getProductsSaved);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Ma Liste de Courses'),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 0.8,
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height * 0.7,
                child: list.when(
                  data: (products) => ListWidget(products: products!),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Text('Error: $err'),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.1,
                child: Center(
                  child: FilledButton(
                    onPressed: () {
                      openDeleteDialog(context);
                    },
                    child: const Text('Supprimer'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openDeleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return DeleteDialog();
      },
    );
  }
}
