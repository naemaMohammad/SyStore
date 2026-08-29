import 'package:get/get.dart';
import 'package:user_app/data/model/cart_delivery_zones_model.dart';
import 'package:user_app/data/model/create_order_model.dart';
import 'package:user_app/data/model/view_cart_model.dart';
import 'package:user_app/data/services/api_client.dart';

class ViewCartController extends GetxController {
  RxBool isLoading = true.obs;

  Rxn<view_cart_model> cartModel = Rxn<view_cart_model>();
  RxList<Variants> products = <Variants>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
    getDeliveryZones();
  }

  Future<void> getCart() async {
    try {
      isLoading.value = true;

      final api = Get.find<ApiClient>();
      final response = await api.viewCart();
      final data = response is Map<String, dynamic>
          ? view_cart_model.fromJson(response)
          : null;

      cartModel.value = data;
      products.assignAll(data?.cart?.variants ?? []);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<DeliveryZones> deliveryZones = <DeliveryZones>[].obs;

  DeliveryZones? selectedZone;

  RxString selectedRegion = "".obs;

  RxInt expandedSectorIndex = (-1).obs;

  void setExpandedSector(int index, bool expanded) {
    if (expanded) {
      expandedSectorIndex.value = index;
    } else if (expandedSectorIndex.value == index) {
      expandedSectorIndex.value = -1;
    }
  }

  Future<void> getDeliveryZones() async {
    try {
      final api = Get.find<ApiClient>();
      final response = await api.cartDeliveryZones();
      final data = response is Map<String, dynamic>
          ? cart_delivery_zones_model.fromJson(response)
          : null;

      deliveryZones.assignAll(data?.deliveryZones ?? []);
    } catch (e) {
      print(e);
    }
  }

  void selectRegion(DeliveryZones zone, String region) {
    selectedZone = zone;
    selectedRegion.value = region;
    expandedSectorIndex.value = -1;
  }

  Future<void> increaseQty(int index) async {
    try {
      final item = products[index];
      int newQty = (item.pivot?.quantity ?? 0) + 1;

      final api = Get.find<ApiClient>();
      await api.updateCart({"product_variant_id": item.id, "quantity": newQty});

      item.pivot?.quantity = newQty;
      products.refresh();
      await getCart();
      products.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> decreaseQty(int index) async {
    try {
      final item = products[index];
      int currentQty = item.pivot?.quantity ?? 1;
      if (currentQty <= 1) return;

      int newQty = currentQty - 1;

      final api = Get.find<ApiClient>();
      await api.updateCart({"product_variant_id": item.id, "quantity": newQty});

      item.pivot?.quantity = newQty;
      products.refresh();
      await getCart();
      products.refresh();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteItem(int index) async {
    try {
      final item = products[index];
      final api = Get.find<ApiClient>();
      await api.removeCart({"product_variant_id": item.id});

      products.removeAt(index);
      await getCart();
    } catch (e) {
      print(e);
    }
  }

Future<void> createOrder(Map<String, dynamic> body) async {
  try {
    final api = Get.find<ApiClient>();
    final response = await api.createOrder(body);
    final data = response is Map<String, dynamic>
        ? create_order_model.fromJson(response)
        : null;

    if (data?.order != null) {
      await Get.find<ViewCartController>().clearCart();
      
      products.clear();
      cartModel.value = null;
      
      products.refresh();
    }
  } catch (e) {
    print(e);
  }
}

  Future<void> clearCart() async {
    try {
      final api = Get.find<ApiClient>();
      final res = await api.clearCart();
      print("CLEAR CART RESPONSE => $res");
    } catch (e) {
      print("CLEAR CART ERROR => $e");
    }
  }

  int get total => subTotal + delivery;

  int get delivery =>
      (double.tryParse(selectedZone?.pivot?.price ?? "0") ?? 0).toInt();

  int get subTotal =>
      int.tryParse(cartModel.value?.subTotal?.toString() ?? "0") ?? 0;
}
