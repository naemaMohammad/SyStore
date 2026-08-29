// lib/app/bindings/create_store_binding.dart
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/create_store_controller.dart';


class CreateStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateStoreController>(() => CreateStoreController());
  }
}