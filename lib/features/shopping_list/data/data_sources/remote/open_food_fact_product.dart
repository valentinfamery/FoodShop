import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactProduct {
  Future<List<Product?>?> searchByName(
      String name,
      PnnsGroup2? pnnsGroup2,
      String termBrand,
      String termStore,
      String termIngredient,
      String barcode,
      OpenFoodFactsCountry country,
      OpenFoodFactsLanguage language) async {
    var parameterList = <Parameter>[];

    if (name != '') {
      parameterList.add(SearchTerms(terms: [name]));
    }

    if (barcode != '') {
      parameterList.add(BarcodeParameter(barcode));
    }

    if (termBrand != '') {
      parameterList.add(TagFilter.fromType(
        tagFilterType: TagFilterType.BRANDS,
        tagName: termBrand,
      ));
    }

    if (termStore != '') {
      parameterList.add(TagFilter.fromType(
        tagFilterType: TagFilterType.STORES,
        tagName: termStore,
      ));
    }

    if (termIngredient != '') {
      parameterList.add(TagFilter.fromType(
        tagFilterType: TagFilterType.INGREDIENTS,
        tagName: termIngredient,
      ));
    }

    if (pnnsGroup2 != null) {
      parameterList.add(PnnsGroup2Filter(pnnsGroup2: pnnsGroup2));
    }

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
            country: country,
            language: language,
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
