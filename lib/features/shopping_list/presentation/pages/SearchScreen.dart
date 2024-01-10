import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/ProductEntity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  final myController = TextEditingController();

  ProductRepository productRepository = ProductRepositoryImpl();

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
            child: ListView.builder(
              itemCount: listSearchProduct.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listSearchProduct[index].name ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchProductByName(String name) async {
    final listAPI = await productRepository.searchProductByName(name);
    for (var element in listAPI) {
      print(element.name);
    }
    setState(() {
      listSearchProduct = listAPI;
    });
  }
}
