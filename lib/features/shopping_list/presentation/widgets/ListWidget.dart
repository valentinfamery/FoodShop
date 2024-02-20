import 'package:flutter/material.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';

class ListWidget extends StatelessWidget {
  final List<Product> products;

  ListWidget({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(products.length, (index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: InkWell(
            onTap: () {
              //GoRouter.of(context).go('/list/details', extra: 'Card ${index + 1}');
              // Action à effectuer lors du clic
            },
            child:

                // Votre contenu de boîte ici
                Center(
              child: Text(
                'Card ${products[index].name}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      }),
    );
  }
}
