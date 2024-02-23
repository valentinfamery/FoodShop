import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              GoRouter.of(context).go('/list/details', extra: products[index]);
            },
            child: Column(
              children: <Widget>[
                Text(
                  '${products[index].name}',
                  style: const TextStyle(fontSize: 20),
                ),
                FittedBox(
                  child: CachedNetworkImage(
                    imageUrl: products[index].imageFrontUrl!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  fit: BoxFit.fill,
                )
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
