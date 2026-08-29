import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/ads/ads_controller.dart';
import 'package:user_app/controller/ai_search/search_controller.dart';
import 'package:user_app/controller/cart/CartController.dart';
import 'package:user_app/controller/cart/cart_controller.dart';
import 'package:user_app/controller/favorite/favorite_controller.dart';
import 'package:user_app/controller/filter/filter_controller.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/controller/order/EditOrderController.dart';
import 'package:user_app/controller/order/ShowOrderController.dart';
import 'package:user_app/controller/order/viewOrderController.dart';
import 'package:user_app/controller/product/product_controller.dart';
import 'package:user_app/controller/product/product_detailed_controller.dart';
import 'package:user_app/controller/reports/report_controller.dart';
import 'package:user_app/controller/settings/settings_controller.dart';
import 'package:user_app/controller/store/store_controller.dart';

import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/data/services/dio_provider.dart';
import 'package:user_app/data/services/token_service.dart';

class ApiBindings extends Bindings {
  @override
  void dependencies() {
    // --- Core infrastructure ---
    Get.put<TokenService>(TokenService(), permanent: true);
    Get.put<Dio>(buildDio(tokenService: Get.find<TokenService>()), permanent: true);
    Get.put<ApiClient>(ApiClient(Get.find<Dio>()), permanent: true);

    // --- API Controllers (permanent) ---
    Get.put<StoreController>(StoreController(), permanent: true);
    Get.put<ProductController>(ProductController(), permanent: true);
    Get.put<FavoriteController>(FavoriteController(), permanent: true);
    Get.put<ReportController>(ReportController(), permanent: true);
    Get.put<CartController>(CartController(), permanent: true);  // ← API Cart
    Get.put<SearchController>(SearchController(), permanent: true);

    // --- UI Controllers (fenix) ---
    Get.lazyPut<MainLayoutController>(() => MainLayoutController(), fenix: true);
    Get.lazyPut<AdsController>(() => AdsController(), fenix: true);
    
    // ✅ رانيم Controllers
    Get.lazyPut<ViewCartController>(() => ViewCartController(), fenix: true);
    Get.lazyPut<OrdersController>(() => OrdersController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<EditOrderController>(() => EditOrderController(), fenix: true);
    Get.lazyPut<Showmycartcontroller>(() => Showmycartcontroller(), fenix: true);

    // --- Per-screen controllers ---
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(),
      fenix: true,
    );
    Get.lazyPut<FilterController>(() => FilterController(), fenix: true);
  }
}