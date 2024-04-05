import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';

class GridElement extends StatefulWidget {
  final ProductFoodShop product;

  const GridElement({required this.product, super.key});

  @override
  State<GridElement> createState() => _GridElement();
}

class _GridElement extends State<GridElement> {
  @override
  Widget build(BuildContext context) {
    bool isBuy = widget.product.isBuy!;

    final pastScreen =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final height = MediaQuery.of(context).size.height * 0.10;
    final width = MediaQuery.of(context).size.width * 0.90;

    return InkWell(
      onTap: () {
        if (pastScreen == '/list') {
          GoRouter.of(context).go('/list/details', extra: widget.product);
        } else if (pastScreen == '/search') {
          GoRouter.of(context).go('/search/details', extra: widget.product);
        }
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: height,
            width: height,
            child: widget.product.imageFrontUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.product.imageFrontUrl!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : const Center(child: Text('Non disponible')),
          ),
          const Spacer(),
          SizedBox(
            width: width * 0.50,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.50,
                  height: height * 0.50,
                  child: Text(
                    '${widget.product.name}',
                    style: TextStyle(
                        fontSize: height * 0.20,
                        decoration: isBuy
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: width * 0.50,
                  height: height * 0.50,
                  child: Text(
                    '1' + 'x ${widget.product.weight ?? ''}',
                    style: TextStyle(
                      fontSize: height * 0.20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          pastScreen == '/list'
              ? SizedBox(
                  height: height,
                  width: width * 0.20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Checkbox(
                      value: isBuy,
                      onChanged: (bool? value) {
                        setState(() {
                          isBuy = value!;
                        });
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: height,
                  width: width * 0.20,
                ),
        ],
      ),
    );
  }
}
