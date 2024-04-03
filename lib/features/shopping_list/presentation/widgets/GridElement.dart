import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    final width = MediaQuery.of(context).size.width / 2;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).go('/list/details', extra: widget.product);
        },
        child: Column(
          children: <Widget>[
            Text(
              '${widget.product.name}',
              style: TextStyle(
                  fontSize: 20,
                  decoration:
                      isBuy ? TextDecoration.lineThrough : TextDecoration.none),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: width * 0.30,
              width: width * 0.45,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.product.imageFrontUrl!,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Checkbox(
              value: isBuy,
              onChanged: (bool? value) {
                setState(() {
                  isBuy = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
