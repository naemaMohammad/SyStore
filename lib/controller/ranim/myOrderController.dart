import 'package:get/get.dart';

class OrdersController extends GetxController {
  var orders = <Order>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    try {
      isLoading.value = true;
      final data = await OrderService.fetchOrders();
      orders.value = data;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

class OrderService {
  static Future<List<Order>> fetchOrders() async {
    await Future.delayed(const Duration(seconds: 1)); // loading

    return [
      Order(id: "1001", date: "2024-01-01", total: "25", status: "Process"),
      Order(id: "1002", date: "2024-01-02", total: "40", status: "Preparing"),
      Order(id: "1003", date: "2024-01-03", total: "60", status: "On the way"),
      Order(id: "1004", date: "2024-01-04", total: "80", status: "Delivered"),
      Order(id: "1005", date: "2024-01-05", total: "15", status: "Cancelled"),
    ];
  }
}

class Order {
  final String id;
  final String date;
  final String total;
  final String status;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
  });
}