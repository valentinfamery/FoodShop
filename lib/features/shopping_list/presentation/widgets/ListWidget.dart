import 'package:flutter/material.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';

class ListWidget extends StatelessWidget {
  final List<Product> products;

  ListWidget({required this.products, super.key});

  var productRepository = sl<ProductRepository>();

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
            child: Column(
              children: <Widget>[
                Text(
                  '${products[index].name}',
                  style: const TextStyle(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      productRepository.deleteProductFloor(products[index]);
                    },
                    child: Text('Delete'))
              ],
            ),
          ),
        );
      }
          // Votre contenu de boîte ici

          ),
    );
  }
}
