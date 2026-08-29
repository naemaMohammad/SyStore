import 'package:get/get.dart';
import 'package:user_app/data/model/view_order_model.dart';
import 'package:user_app/data/services/api_client.dart';

class OrdersController extends GetxController {
  RxBool isLoading = true.obs;

  RxList<Orders> orders = <Orders>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final api = Get.find<ApiClient>();
      final response = await api.viewOrders();
      final data = response is Map<String, dynamic>
          ? view_order_model.fromJson(response)
          : null;

      orders.assignAll(data?.orders ?? []);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  final selectedFilter = "All".obs;

  List<Orders> get filteredOrders {
    if (selectedFilter.value == "All") {
      return orders;
    }

    return orders.where((order) {
      return getStatus(order.status) == selectedFilter.value;
    }).toList();
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  String getStatus(String? status) {
    switch (status) {
      case "process":
        return "Process";
      case "preparing":
        return "Preparing";
      case "on_the_way":
        return "On the way";
      case "delivered":
        return "Delivered";
      case "cancelled":
        return "Cancelled";
      case "rejected":
        return "Rejected";
      default:
        return "";
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      isLoading.value = true;

      final api = Get.find<ApiClient>();
      final response = await api.cancelOrder(orderId);

      Get.snackbar(
        "Success",
        response is Map<String, dynamic>
            ? (response['message'] ?? "Order cancelled successfully")
            : "Order cancelled successfully",
      );

      await fetchOrders();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

