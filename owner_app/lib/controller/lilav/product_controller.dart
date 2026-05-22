import 'package:get/get.dart';
import 'package:owner_app/data/model/myProduct.dart';

class ProductController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;

RxList<ProductModel> filteredProducts =
    <ProductModel>[].obs; 

RxBool isLoading = false.obs;

    RxBool isFiltering = false.obs;


void toggleActivation(ProductModel product){
    product.isActive = !product.isActive;
    products.refresh();
  }

  
 Future<void> addProduct(
  ProductModel product,
) async {

  isLoading.value = true;

  await Future.delayed(
    const Duration(seconds: 4),
  );

  products.add(product);

  isLoading.value = false;
}
 
  void toggleProductStatus(String productId) {

  final index = products.indexWhere(
    (product) => product.id == productId,
  );

  if (index != -1) {

    products[index].isActive =
        !products[index].isActive;

    products.refresh();
  }
}

Future<void> removeProduct(
  ProductModel product,
) async {

  isLoading.value = true;

  await Future.delayed(
    const Duration(seconds: 2),
  );

  products.remove(product);

  products.refresh();

  isLoading.value = false;
}

Future<void> updateProduct(
  ProductModel updatedProduct,
) async {

  isLoading.value = true;

  await Future.delayed(
    const Duration(seconds: 2),
  );

  final index = products.indexWhere(
    (p) => p.id == updatedProduct.id,
  );

  if (index != -1) {

    products[index] = updatedProduct;

    products.refresh();
  }

  isLoading.value = false;
}

}
