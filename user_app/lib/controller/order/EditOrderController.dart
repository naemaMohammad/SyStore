import 'package:get/get.dart';
import 'package:user_app/data/model/cart_delivery_zones_model.dart';
import 'package:user_app/data/model/show_order_model.dart';
import 'package:user_app/data/services/api_client.dart';

class EditOrderController extends GetxController {
  RxBool isLoading = true.obs;

  RxList<Variants> products = <Variants>[].obs;
  RxList<DeliveryZones> deliveryZones = <DeliveryZones>[].obs;

  RxString selectedRegion = "".obs;
  RxString selectedSector = "".obs;

  Rxn<int> expandedZoneId = Rxn<int>();

  DeliveryZones? selectedZone;
  int? selectedZoneId;

  int? orderId;

  double delivery = 0;

  String customerPhone = "";
  String address = "";
  String addressDetails = "";

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    orderId = args?['id'];

    if (orderId == null) {
      isLoading.value = false;
      return;
    }

    _loadData();
  }

  Future<void> _loadData() async {
    await fetchOrder();
    await fetchDeliveryZones();
  }

  Future<void> fetchOrder() async {
    try {
      isLoading.value = true;

      final api = Get.find<ApiClient>();
      final response = await api.showOrder(orderId!);
      final data = response is Map<String, dynamic>
          ? show_order_model.fromJson(response)
          : null;

      final order = data?.order;

      products.assignAll(order?.variants ?? []);

      delivery = double.tryParse(order?.deliveryFee ?? "0") ?? 0;
      customerPhone = order?.customerPhone ?? "";
      address = order?.address ?? "";
      addressDetails = order?.addressDetails ?? "";

      if (order?.deliveryZone != null) {
        selectedZoneId = order!.deliveryZone!.id;

        final isArabic = Get.locale?.languageCode == 'ar';
        final sectorName = isArabic
            ? order.deliveryZone!.sectorNameAr
            : order.deliveryZone!.sectorNameEn;

        selectedSector.value = (sectorName != null && sectorName.isNotEmpty)
            ? sectorName
            : (order.deliveryZone!.sectorNameEn ?? "");

        final regionsRaw = isArabic
            ? order.deliveryZone!.regionsAr
            : order.deliveryZone!.regionsEn;

        final source = (regionsRaw != null && regionsRaw.trim().isNotEmpty)
            ? regionsRaw
            : (order.deliveryZone!.regionsEn ?? "");

        if (source.isNotEmpty) {
          selectedRegion.value = source.split(RegExp(r'[,،]')).first.trim();
        } else {
          selectedRegion.value = "";
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDeliveryZones() async {
    try {
      final api = Get.find<ApiClient>();
      final response = await api.cartDeliveryZones(orderId: orderId);
      final data = response is Map<String, dynamic>
          ? cart_delivery_zones_model.fromJson(response)
          : null;

      deliveryZones.assignAll(data?.deliveryZones ?? []);
      print("deliveryZones count = ${deliveryZones.length}");
    } catch (e) {
      print("DeliveryZones error: $e");
      deliveryZones.clear();
    }
  }

  void selectRegion(DeliveryZones zone, String region) {
    selectedZone = zone;
    selectedSector.value = zone.sectorName;
    selectedRegion.value = region;
    delivery = double.tryParse(zone.pivot?.price ?? "0") ?? 0;
    selectedRegion.refresh();
  }

  void toggleZoneExpansion(int? zoneId) {
    if (zoneId == null) return;
    if (expandedZoneId.value == zoneId) {
      expandedZoneId.value = null;
    } else {
      expandedZoneId.value = zoneId;
    }
  }

  double get subTotal {
    double sum = 0;
    for (final item in products) {
      final price = double.tryParse(item.pivot?.price ?? "0") ?? 0;
      final qty = item.pivot?.quantity ?? 0;
      sum += price * qty;
    }
    return sum;
  }

  double get total => subTotal + delivery;

  Future<void> updateOrder(Map<String, dynamic> body) async {
    final zoneId = selectedZone?.id ?? selectedZoneId;
    final finalBody = {...body, "delivery_zone_id": zoneId};
    final api = Get.find<ApiClient>();
    await api.updateOrder(orderId!, finalBody);
  }
}
