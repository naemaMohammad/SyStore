import 'package:get/get.dart';
import 'package:user_app/view/lilav/widgets/product_card.dart';

class StoreController extends GetxController {

  RxList<ProductCard> filteredProducts = <ProductCard>[].obs;

  void initializeProducts(List<ProductCard> products) {
    filteredProducts.value = products;
  }

  void applyFilters(List<ProductCard> results) {
    filteredProducts.value = results;
  }

  void filterByCategory(String? category) {

    if (category == null || category == 'All') {
      filteredProducts.value = List.from(ProductCard.allProducts);
    } else {
      filteredProducts.value = ProductCard.allProducts.where((p) =>
        p.category.toLowerCase() == category.toLowerCase()
      ).toList();
    }
  }

  void sortByPrice(bool highToLow) {

    filteredProducts.sort((a, b) =>
      highToLow
      ? b.priceValue.compareTo(a.priceValue)
      : a.priceValue.compareTo(b.priceValue)
    );

    filteredProducts.refresh();
  }
}