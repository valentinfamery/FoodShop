import 'package:meal_maven/features/shopping_list/data/data_sources/remote/open_food_fact_product.dart';
import 'package:meal_maven/features/shopping_list/domain/entities/product_entity.dart';
import 'package:meal_maven/features/shopping_list/domain/repository/ProductRepository.dart';

class ProductRepositoryImpl implements ProductRepository {
  
  final apiOpenFoodFact = OpenFoodFactProduct();
  @override
  Future<List<ProductEntity>> searchProductByName(String name) async {
    final listSearchApiProduct = await apiOpenFoodFact.searchByName(name);

    List<ProductEntity> listSearchProductFinal = <ProductEntity>[];

    for (var element in listSearchApiProduct!) {
      final name = element!.productName;
      final imageFrontUrl = element.imageFrontUrl;

      listSearchProductFinal
          .add(ProductEntity(name: name, imageFrontUrl: imageFrontUrl));
    }

    return listSearchProductFinal;
  }
}
