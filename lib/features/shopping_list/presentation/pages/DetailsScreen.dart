import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {
  /// The label to display in the center of the screen.
  final Product? productEntity;

  /// Constructs a [DetailsScreen].
  DetailsScreen({
    this.productEntity,
    super.key,
  });

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          productEntity!.name ?? '',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var random = Random();
          var randomNumber = random.nextInt(900000) + 100000;
          productRepository.insertProductInFloor(productEntity!);
          // Ajoutez votre logique ici
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
