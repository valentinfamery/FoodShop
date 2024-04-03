import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactProduct {
  Future<List<Product?>?> searchByName(
      String name, PnnsGroup2? pnnsGroup2) async {
    var parameterList = <Parameter>[];

    if (pnnsGroup2 != null) {
      parameterList = <Parameter>[
        SearchTerms(terms: [name]),
        PnnsGroup2Filter(pnnsGroup2: pnnsGroup2),
      ];
    } else {
      parameterList = <Parameter>[
        SearchTerms(terms: [name]),
      ];
    }

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
            language: OpenFoodFactsLanguage.FRENCH,
            version: ProductQueryVersion.v3,
            parametersList: parameterList);

    SearchResult result = await OpenFoodAPIClient.searchProducts(
      const User(userId: '', password: ''),
      configuration,
    );

    final searchList = result.products;

    return searchList;
  }
}
