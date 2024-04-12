import 'package:flutter/material.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:food_shop/injection_container.dart';

class DeleteDialog extends StatelessWidget {
  DeleteDialog({super.key});

  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Supprimer toute la liste"),
      content: const SizedBox(
        width: 300,
        height: 400,
        child: Center(
          child: Text('Etes vous sur de vouloir supprimer toutes la liste ?'),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Confirmer'),
          onPressed: () {
            productRepository.deleteProducts();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
