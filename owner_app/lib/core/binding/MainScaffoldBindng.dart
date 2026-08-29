// lib/core/binding/MainScaffoldBindng.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/dashboard/dashController.dart';
import 'package:owner_app/controller/orders/orderController.dart';
import 'package:owner_app/controller/products/product_controller.dart';
import 'package:owner_app/controller/settings/settings_controller.dart';
import 'package:owner_app/controller/stores/store_controller.dart';

class MainScaffoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<StoreController>(() => StoreController(), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<OrdersController>(() => OrdersController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
  }
}