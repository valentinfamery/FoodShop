import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactProduct {
  Future<List<Product?>?> searchByName(
      String name,
      PnnsGroup2? pnnsGroup2,
      String termBrand,
      String termStore,
      String termIngredient,
      String barcode,
      OpenFoodFactsCountry country) async {
    var parameterList = <Parameter>[];

    if (pnnsGroup2 != null) {
      parameterList = <Parameter>[
        SearchTerms(terms: [name]),
        TagFilter.fromType(
          tagFilterType: TagFilterType.BRANDS,
          tagName: termBrand,
        ),
        TagFilter.fromType(
          tagFilterType: TagFilterType.STORES,
          tagName: termStore,
        ),
        TagFilter.fromType(
          tagFilterType: TagFilterType.INGREDIENTS,
          tagName: termIngredient,
        ),
        BarcodeParameter(barcode),
        PnnsGroup2Filter(pnnsGroup2: pnnsGroup2),
      ];
    } else {
      parameterList = <Parameter>[
        SearchTerms(terms: [name]),
        TagFilter.fromType(
          tagFilterType: TagFilterType.BRANDS,
          tagName: termBrand,
        ),
        TagFilter.fromType(
          tagFilterType: TagFilterType.STORES,
          tagName: termStore,
        ),
        TagFilter.fromType(
          tagFilterType: TagFilterType.INGREDIENTS,
          tagName: termIngredient,
        ),
        BarcodeParameter(barcode),
      ];
    }

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
            country: country,
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
