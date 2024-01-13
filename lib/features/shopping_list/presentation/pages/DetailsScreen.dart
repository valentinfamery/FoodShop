import 'package:flutter/material.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/product_entity.dart';

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {
  /// The label to display in the center of the screen.
  final ProductEntity? productEntity;

  /// Constructs a [DetailsScreen].
  DetailsScreen({
    this.productEntity,
    super.key,
  });

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
    );
  }
}
