import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';

class DetailsScreen extends StatefulWidget {
  final Product? productEntity;

  DetailsScreen({
    this.productEntity,
    super.key,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreen();
}

/// The details screen for either the A, B or C screen.
class _DetailsScreen extends State<DetailsScreen> {
  /// The label to display in the center of the screen.

  /// Constructs a [DetailsScreen].

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          widget.productEntity!.name ?? '',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.productEntity?.isSaved == false) {
            var random = Random();
            var randomNumber = random.nextInt(900000) + 100000;
            productRepository.insertProductInFloor(widget.productEntity!);
          } else {
            productRepository.deleteProductFloor(widget.productEntity!);
          }
        },
        backgroundColor: Colors.green,
        child: widget.productEntity!.isSaved == true
            ? Icon(Icons.done)
            : Icon(Icons.add),
      ),
    );
  }
}
