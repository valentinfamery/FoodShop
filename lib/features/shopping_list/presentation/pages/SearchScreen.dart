import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/data/repository/ProductRepositoryImpl.dart';
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

  List<Product> listSearchProduct = [];

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(controller: myController,decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'Enter a search term',
  ),),
          ElevatedButton(
            onPressed: () {
              searchProductByName(myController.text);
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
      itemCount:listSearchProduct.length, 
      itemBuilder: (BuildContext contextItem, int index) { 

        return Card(
             
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          
          child: InkWell(
            onTap: () {
              GoRouter.of(context).go('/search/details',
                            extra: listSearchProduct[index]);
            },
            child: Column(
              children: <Widget>[
                Text(
                  '${listSearchProduct[index].name}',
                  style: TextStyle(fontSize: width * 0.07),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: width * 0.50,
                  width: width * 0.50,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: listSearchProduct[index].imageFrontUrl!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
        


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
      if (kDebugMode) {
        print(element.name);
      }
    }
    setState(() {
      listSearchProduct = listAPI;
    });
  }
}

