import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Center(child:  Text('Ma Liste de Courses'),),),
      body: list.when(
        data: (products) => ListWidget(products: products!),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
