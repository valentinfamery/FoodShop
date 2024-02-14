import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/product_entity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';
import 'package:meal_maven/injection_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final myController = TextEditingController();

  var productRepository = sl<ProductRepository>();

  List<ProductEntity> listSearchProduct = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(controller: myController),
          ElevatedButton(
            onPressed: () {
              searchProductByName(myController.text);
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(listSearchProduct.length, (index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: InkWell(
                      onTap: () {
                        GoRouter.of(context).go('/search/details',
                            extra: listSearchProduct[index]);
                        // Action à effectuer lors du clic
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                              listSearchProduct[index].imageFrontUrl ?? '',
                              fit: BoxFit.cover),
                          SizedBox(height: 10),
                          Text(listSearchProduct[index].name ?? '',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ],
                      )),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void searchProductByName(String name) async {
    final listAPI = await productRepository.searchProductByName(name);
    for (var element in listAPI) {
      if (kDebugMode) {
        print(element.name);
      }
    }
    setState(() {
      listSearchProduct = listAPI;
    });
  }
}
