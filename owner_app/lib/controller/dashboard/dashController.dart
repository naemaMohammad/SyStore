
import 'package:get/get.dart';
import 'package:owner_app/data/data_source/api_call.dart';
import 'package:owner_app/data/services/api_service.dart';

class DashboardController extends GetxController {
  final ApiCall api = ApiService.apiCall;
  /// =========================
  /// DATA
  /// =========================

  final totalSales = "0 SYP".obs;

  final newOrders = 0.obs;
  final totalOrders = 0.obs;
  final onTheWay = 0.obs;
  final reviews = 0.obs;

  final weeklyRevenue = <double>[].obs;
  final weekDays = <String>[].obs;

  /// =========================
  /// ACTIONS
  /// =========================

  void onNewOrdersPressed() {
    Get.toNamed(
      '/order',
      arguments: "Process",
    );
  }

  void onTotalOrdersPressed() {
    Get.toNamed('/order');
  }

  void onOnTheWayPressed() {
    Get.toNamed(
      '/order',
      arguments: "On the way",
    );
  }

  void onReviewsPressed() {
    Get.toNamed('/reviews');
  }

  /// =========================
  /// API
  /// =========================

  Future<void> getDashboardData() async {
  try {
    /// Dashboard
    final dashboardResponse = await api.dashboard();

    totalSales.value =
        "${dashboardResponse.data?.totalSales ?? 0} SYP";

    newOrders.value =
        dashboardResponse.data?.newOrders ?? 0;

    totalOrders.value =
        dashboardResponse.data?.totalOrders ?? 0;

    onTheWay.value =
        dashboardResponse.data?.onTheWayOrders ?? 0;

    reviews.value =
        dashboardResponse.data?.reviewsCount ?? 0;

    /// Chart
    final chartResponse = await api.dashboardChart();

    final newRevenue = <double>[];
    final newDays = <String>[];

    for (var item in chartResponse.data ?? []) {
      newRevenue.add(
        (item.orders ?? 0).toDouble(),
      );

      newDays.add(
        item.day ?? "",
      );
    }

    weeklyRevenue.assignAll(newRevenue);
    weekDays.assignAll(newDays);
  } catch (e) {
    print("Dashboard Error: $e");
  }
}

  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }
}