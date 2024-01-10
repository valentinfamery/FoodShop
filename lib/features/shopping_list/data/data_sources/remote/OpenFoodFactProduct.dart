import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactProduct {
  Future<List<Product?>?> searchByName(String name) async {
    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      language: OpenFoodFactsLanguage.FRENCH,
      version: ProductQueryVersion.v3,
      parametersList: <Parameter>[
        SearchTerms(terms: [name]),
      ],
    );

    SearchResult result = await OpenFoodAPIClient.searchProducts(
      User(userId: '', password: ''),
      configuration,
    );

    final searchList = result.products;

    return searchList;
  }
}
