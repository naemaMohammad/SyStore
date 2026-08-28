import 'package:owner_app/data/data_source/api_call.dart';
import 'package:get/get.dart';
import 'package:owner_app/data/model/view_orders_model.dart';
import 'package:owner_app/data/services/api_service.dart';

class OrdersController extends GetxController {
  // نفس نسخة الـ ApiCall المشتركة (المسجّلة في ApiService.init) بدل whathappens().
  final ApiCall api = ApiService.apiCall;

  RxList<Orders> orders = <Orders>[].obs;

  RxString selectedFilter = "All".obs;
  RxString searchQuery = "".obs;
  RxBool isSearching = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final filter = Get.arguments;
    if (filter != null) selectedFilter.value = filter;
    fetchOrders();
  }

  // ================= FETCH =================
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final response = await api.viewOrder();
      orders.value = response.orders ?? [];
    } catch (e) {
      print("FETCH ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= NORMALIZE =================
  String norm(String? s) =>
      s?.toLowerCase().replaceAll("-", "_") ?? "";

  // ================= FILTER =================
  List<Orders> get filteredOrders {
    List<Orders> list = orders;

    switch (selectedFilter.value) {
      case "Process":
        list = list.where((e) => norm(e.status) == "process").toList();
        break;
      case "Preparing":
        list = list.where((e) => norm(e.status) == "preparing").toList();
        break;
      case "On the way":
        list = list.where((e) => norm(e.status) == "on_the_way").toList();
        break;
      case "Delivered":
        list = list.where((e) => norm(e.status) == "delivered").toList();
        break;
    }

    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((o) =>
              (o.id?.toString() ?? "")
                  .contains(searchQuery.value))
          .toList();
    }

    return list;
  }

  // ================= ACCEPT =================
  Future<void> acceptOrder(Orders order) async {
    if (order.id == null) return;

    try {
      await api.acceptOrder(order.id!);
      _updateStatus(order.id!, "preparing");
    } catch (e) {
      print("ACCEPT ERROR: $e");
    }
  }

  // ================= REJECT =================
  Future<void> rejectOrder(Orders order, String reason) async {
    if (order.id == null) return;

    try {
      await api.rejectOrder(order.id!, {"reason": reason});
      orders.removeWhere((e) => e.id == order.id);
    } catch (e) {
      print("REJECT ERROR: $e");
    }
  }

  // ================= STATUS =================
  Future<void> changeStatus(Orders order, String status) async {
    if (order.id == null) return;

    try {
      await api.statusOrder(order.id!, {"status": status});
      _updateStatus(order.id!, status);
    } catch (e) {
      print("STATUS ERROR: $e");
    }
  }

  void _updateStatus(int id, String status) {
    final index = orders.indexWhere((e) => e.id == id);
    if (index != -1) {
      orders[index].status = status;
      orders.refresh();
    }
  }

  void changeFilter(String v) => selectedFilter.value = v;
}