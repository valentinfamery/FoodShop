import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  final ProductFoodShop? productEntity;

  const DetailsScreen({
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

  bool? isSaved = false;

  @override
  void initState() {
    super.initState();

    final pastScreen =
        GoRouter.of(context).routeInformationProvider.value.location.toString();

    if (kDebugMode) {
      print(pastScreen.toString());
    }

    if (pastScreen == '/list/details') {
      isSaved = widget.productEntity!.isSaved;
    } else if (pastScreen == '/search/details') {
      isSavedFutureVoid();
    }
  }

  void isSavedFutureVoid() async {
    final isSavedFuture = await productRepository
        .isProductSaved(widget.productEntity!.barcodeId!);
    if (kDebugMode) {
      print(isSavedFuture.toString());
    }

    setState(() {
      isSaved = isSavedFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Column(
        children: [
          Text(
            widget.productEntity!.name ?? '',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(widget.productEntity!.weight ?? ''),
          SizedBox(
            height: width * 0.80,
            width: width * 0.80,
            child: widget.productEntity!.imageFrontUrl != null
                ? CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: widget.productEntity!.imageFrontUrl!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const Text('Non disponible'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isSaved == false) {
            productRepository.insertProductInFloor(widget.productEntity!);

            setState(() {
              isSaved = true;
            });
          } else {
            setState(() {
              isSaved = false;
            });

            productRepository.deleteProductFloor(widget.productEntity!);
          }
        },
        child: isSaved == true ? const Icon(Icons.done) : const Icon(Icons.add),
      ),
    );
  }
}
