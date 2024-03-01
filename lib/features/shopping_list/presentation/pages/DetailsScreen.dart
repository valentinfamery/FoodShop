import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
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

  bool? isSaved = false ;

  @override
  void initState() {
    super.initState();

    isSaved = widget.productEntity!.isSaved;
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Column(children: [

              Text(
          widget.productEntity!.name ?? '',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        Text(widget.productEntity!.quantity ?? ''),

        SizedBox(
                  height: width * 0.80,
                  width: width * 0.80,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget.productEntity!.imageFrontUrl!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),

      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.productEntity?.isSaved == false) {
            var random = Random();
            var randomNumber = random.nextInt(900000) + 100000;
            productRepository.insertProductInFloor(widget.productEntity!);

            setState(() {
              isSaved = true;
            });

          } else {
            productRepository.deleteProductFloor(widget.productEntity!);
            setState(() {
              isSaved = false;
            });
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

