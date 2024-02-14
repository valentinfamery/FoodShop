import 'dart:async';

import 'package:meal_maven/features/shopping_list/data/data_sources/local/dao/product_floor_dao.dart';
import 'package:meal_maven/features/shopping_list/data/data_sources/remote/open_food_fact_product.dart';
import 'package:meal_maven/features/shopping_list/data/models/product_floor.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/product_entity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductFloorDao productFloorDao;

  ProductRepositoryImpl(this.productFloorDao);

  final apiOpenFoodFact = OpenFoodFactProduct();

  @override
  Future<List<ProductEntity>> searchProductByName(String name) async {
    final listSearchApiProduct = await apiOpenFoodFact.searchByName(name);

    List<ProductEntity> listSearchProductFinal = <ProductEntity>[];

    for (var element in listSearchApiProduct!) {
      final barcode = element!.barcode;
      final name = element!.productName;
      final imageFrontUrl = element.imageFrontUrl;

      listSearchProductFinal.add(ProductEntity(
          barcodeId: int.parse(barcode!),
          name: name,
          imageFrontUrl: imageFrontUrl));

      print(element.barcode);
    }

    return listSearchProductFinal;
  }

  @override
  void insertProductInFloor() async {
    final productFloor = ProductFloor(16, 'test');
    await productFloorDao.insertProductFloor(productFloor);
    final result = await productFloorDao.getProductFloorById(1);
    print(result?.name);
  }

  @override
  Future<List<ProductFloor>> getAllProductFloor() async {
    // Initializing a stream controller
    StreamController<List<ProductFloor>> controller =
        StreamController<List<ProductFloor>>();

    // Creating a new stream through the controller
    Stream<List<ProductFloor>> stream = controller.stream;

    controller.add(await productFloorDao.getAllProductFloor());

    StreamSubscription<List<ProductFloor>> subscriber =
        stream.listen((List<ProductFloor> data) {
      print(data[1].name);
    }, onError: (error) {
      print(error);
    }, onDone: () {
      print('Stream closed!');
    });

    final result = await productFloorDao.getAllProductFloor();

    if (result.isEmpty) {
      return [];
    } else {
      return result;
    }
  }

  @override
  Stream<List<ProductFloor>> getAllStreamProductFloor() {
    // TODO: implement getAllStreamProductFloor
    throw UnimplementedError();
  }
}
