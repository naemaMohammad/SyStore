import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/view/lilav/widgets/product_card.dart';

class FavoriteController extends GetxController {

  final box = GetStorage();

  RxList<String> favoriteTitles = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    List? saved = box.read('favorites');

    if (saved != null) {
      favoriteTitles.assignAll(saved.cast<String>());
    }
  }

  void toggleFavorite(ProductCard product) {

    if (favoriteTitles.contains(product.title)) {
      favoriteTitles.remove(product.title);
    } else {
      favoriteTitles.add(product.title);
    }

    box.write('favorites', favoriteTitles);
  }

  bool isFavorite(ProductCard product) {
    return favoriteTitles.contains(product.title);
  }

  List<ProductCard> get favoriteProducts {
    return ProductCard.allProducts.where((product) {
      return favoriteTitles.contains(product.title);
    }).toList();
  }
}