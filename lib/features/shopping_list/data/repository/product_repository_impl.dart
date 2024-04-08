import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:food_shop/features/shopping_list/data/data_sources/remote/open_food_fact_product.dart';
import 'package:food_shop/features/shopping_list/data/models/product_floor.dart';
import 'package:food_shop/features/shopping_list/domain/repository/product_repository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {
  final ProductFloorDao productFloorDao;

  ProductRepositoryImpl(this.productFloorDao);

  final apiOpenFoodFact = OpenFoodFactProduct();

  @override
  Future<List<ProductFoodShop>> searchProductByName(
      String name,
      PnnsGroup2? pnnsGroup2,
      String termBrand,
      String termStore,
      String termIngredient,
      OpenFoodFactsCountry country) async {
    final listSearchApiProduct = await apiOpenFoodFact.searchByName(
        name, pnnsGroup2, termBrand, termStore, termIngredient, country);

    List<ProductFoodShop> listSearchProductFinal = <ProductFoodShop>[];

    for (var element in listSearchApiProduct!) {
      final barcode = element!.barcode;
      final name = element.productName;
      final imageFrontUrl = element.imageFrontUrl;
      final weight = element.quantity;
      final nameLanguages = element.productNameInLanguages;

      var client = http.Client();

      final url = Uri.parse(
          'https://prices.openfoodfacts.org/api/v1/prices?product_code=$barcode&page=1&size=50');

      final response =
          await http.get(url, headers: {'accept': 'application/json'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print('Erreur lors de la requête : ${response.statusCode}');
        }
      }

      listSearchProductFinal.add(ProductFoodShop(int.parse(barcode!),
          nameLanguages, imageFrontUrl, false, weight, 1));

      if (kDebugMode) {
        print(element.barcode);
      }
    }

    return listSearchProductFinal;
  }

  @override
  void insertProductInFloor(ProductFoodShop productEntity) async {
    final productFloor = ProductFoodShop(
        productEntity.barcodeId!,
        productEntity.nameLanguages,
        productEntity.imageFrontUrl,
        productEntity.isBuy,
        productEntity.weight,
        productEntity.quantity);
    await productFloorDao.insertProductFloor(productFloor);
  }

  @override
  Stream<List<ProductFoodShop>> getProductsSaved() {
    return productFloorDao.getAllProductFloor();
  }

  @override
  void deleteProductFloor(ProductFoodShop product) async {
    await productFloorDao.deleteProductFloor(product);
  }

  

  @override
  void updateProductFloor(ProductFoodShop product) async {
    await productFloorDao.updateProductFloor(product);
  }

  @override
  Stream<ProductFoodShop?> getProductSavedWithId(int barcodeId) {
    return productFloorDao.getStreamProductFloorById(barcodeId);
  }
}
