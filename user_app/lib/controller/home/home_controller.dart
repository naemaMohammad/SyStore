import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:user_app/controller/product/product_controller.dart';
import 'package:user_app/controller/store/store_controller.dart';

class HomeController extends GetxController {
  final StoreController storeController = Get.find();
  final ProductController productController = Get.find();

  final isLoading = false.obs;
@override
 void onReady() {
    super.onReady();
  loadHome();
}

Future<void> loadHome() async {
  if (isLoading.value) return;

  isLoading.value = true;

  try {
    await Future.wait([
      storeController.getStores(),
      storeController.getTopStores(),
      productController.getTopProducts(),
    ]);
  } finally {
    isLoading.value = false;
  }
}

Future<void> refreshHome() async {
  await Future.wait([
    storeController.getStores(),
    storeController.getTopStores(),
    productController.getTopProducts(forceRefresh: true),
  ]);
}}