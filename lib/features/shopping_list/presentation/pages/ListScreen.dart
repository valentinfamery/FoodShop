import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';

/// The third screen in the bottom navigation bar.

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  var productRepository = sl<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    Future<List<ProductFloor>> _data = Future<List<ProductFloor>>(() => []);

    initState() {
      _data = productRepository.getAllProductFloor();
    }

    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
            stream: productRepository.getAllStreamProductFloor(),
            builder : (BuildContext context, AsyncSnapshot<List<ProductFloor>> snapshot) {
              List<ProductFloor> list = [];

              if (snapshot.data != null) {
                list = snapshot.data!;
              }

              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(list.length, (index) {
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
                      child:

                          // Votre contenu de boîte ici
                          Center(
                        child: Text(
                          'Card ${snapshot.data![index].name}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            
            ));
  }
}
