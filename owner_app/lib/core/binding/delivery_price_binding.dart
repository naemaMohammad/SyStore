// lib/app/bindings/delivery_price_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/delivery_price_controller.dart';


class DeliveryPriceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryPriceController>(() => DeliveryPriceController());
  }
}