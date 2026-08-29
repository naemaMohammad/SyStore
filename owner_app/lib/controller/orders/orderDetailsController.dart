import 'package:get/get.dart';
import 'package:owner_app/data/data_source/api_call.dart';
import 'package:owner_app/data/model/show_order_model.dart';
import 'package:owner_app/data/services/api_service.dart';

class Orderdetailscontroller extends GetxController {
  // استخدم نسخة الـ ApiCall المشتركة المسجّلة في ApiService.init
  // (كانت تستدعي Get.find<ApiCall> غير المسجّل مسبقاً فتُعطل التطبيق).
  final ApiCall api = ApiService.apiCall;

  RxBool isLoading = true.obs;

  Rxn<Order> order = Rxn<Order>();

  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;

  @override
  @override
void onInit() {
  super.onInit();

  print("ON INIT");

  print("ARGUMENT = ${Get.arguments}");

  final int orderId = Get.arguments;

  print("ORDER ID = $orderId");

  fetchOrderDetails(orderId);
}

  Future<void> fetchOrderDetails(int id) async {
      print("FETCH START $id");

    try {
      isLoading.value = true;

      final res = await api.showOrder(id);
      print(order.value?.variants?.first.product?.image);
      print("API DONE");
      order.value = res.order;

      products.value = res.order?.variants?.map((v) {
            return {
              "image": v.product?.image ?? "",
              "title": v.product?.name ?? "",
              "price": v.pivot?.price ?? v.product?.price ?? "",
              "size": v.size?.name ?? "",
              "color": v.color?.name ?? "",
            };
          }).toList() ??
          [];
    } catch (e) {
      print("ORDER DETAILS ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}