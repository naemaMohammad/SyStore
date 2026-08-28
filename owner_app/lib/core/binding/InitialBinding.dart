import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/data/data_source/api_call.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final box = GetStorage();
    String? token = box.read('token');

    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.43.121:8000/api',
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    Get.put<Dio>(dio, permanent: true);

    // Get.put(ProductController());
    // Get.put(StoreController());
    // Get.put(AddProductController());

    Get.put<ApiCall>(
      ApiCall(Get.find<Dio>()),
      permanent: true,
    );
  }
}