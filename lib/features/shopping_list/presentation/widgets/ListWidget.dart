import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:food_shop/features/shopping_list/presentation/widgets/GridElement.dart';
import 'package:food_shop/injection_container.dart';

class ListWidget extends StatelessWidget {
  final List<ProductFoodShop> products;

  ListWidget({required this.products, super.key});

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    var sizeParent = MediaQuery.of(context).size;

    final double height = sizeParent.height;
    final double width = sizeParent.width * 0.90;

    if (products.isNotEmpty) {
      return Center(
        child: SizedBox(
          height: height,
          width: width,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.grey,
                thickness: 1,
              );
            },
            itemCount: products.length,
            itemBuilder: (BuildContext contextItem, int index) {
              return GridElement(
                product: products[index],
              );
            },
          ),
        ),
      );
    } else {
      return const Center(
        child: Text('La liste de Courses est Vide'),
      );
    }

    // Votre contenu de boîte ici
  }
}
