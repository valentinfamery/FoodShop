import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/features/shopping_list/presentation/widgets/ListWidget.dart';
import 'package:meal_maven/injection_container.dart';

/// The third screen in the bottom navigation bar.

final getProductsSaved = StreamProvider.autoDispose<List<Product>?>((ref) {
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
      appBar: AppBar(),
      body: list.when(
        data: (products) => ListWidget(products: products!),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}
