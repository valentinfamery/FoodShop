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
  bool isBuy = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.10;
    final width = MediaQuery.of(context).size.width * 0.90;

    return InkWell(
      onTap: () {
        GoRouter.of(context).go('/list/details', extra: widget.product);
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
            child: Text(
              '${widget.product.name}',
              style: TextStyle(
                  fontSize: 15,
                  decoration:
                      isBuy ? TextDecoration.lineThrough : TextDecoration.none),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
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
          ),
        ],
      ),
    );
  }
}
