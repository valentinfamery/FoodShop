import 'package:meal_maven/features/shopping_list/data/data_sources/remote/OpenFoodFactProduct.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/ProductEntity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final apiOpenFoodFact = OpenFoodFactProduct();
  @override
  Future<List<ProductEntity>> searchProductByName(String name) async {
    final listSearchApiProduct = await apiOpenFoodFact.searchByName(name);

    List<ProductEntity> listSearchProductFinal = <ProductEntity>[];

    for (var element in listSearchApiProduct!) {
      final name = element!.productName;
      listSearchProductFinal.add(ProductEntity(name: name));
    }

    return listSearchProductFinal;
  }
}
