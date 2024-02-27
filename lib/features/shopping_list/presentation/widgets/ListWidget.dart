import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/features/shopping_list/presentation/widgets/GridElement.dart';
import 'package:meal_maven/injection_container.dart';



class ListWidget extends StatelessWidget {

  final List<Product> products;

  ListWidget({required this.products, super.key});

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {



    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
      itemCount:products.length, 
      itemBuilder: (BuildContext contextItem, int index) { 

        return GridElement(product: products[index],);

       },

    );
          // Votre contenu de boîte ici


  }
}


