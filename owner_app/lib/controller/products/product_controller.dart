import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:owner_app/data/data_source/api_calls.dart';
import 'package:owner_app/data/model/ProductModel.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/data/services/token_service.dart';

class ProductController extends GetxController {
  // نفس نسخة الـ ApiCalls المشتركة (المسجّلة في ApiService.init) بدل بناء Dio مستقل.
  final ApiCalls _apiCalls = ApiService.apiCalls;

  RxList<dynamic> products = <dynamic>[].obs;
  RxList<dynamic> filteredProducts = <dynamic>[].obs;
  RxBool isLoading = false.obs;
  RxBool isFiltering = false.obs; // مؤشر التحميل أثناء طلب الفلترة
  RxBool isFilterActive = false.obs; // هل لدينا نتيجة فلترة معروضة الآن؟

  // التوكن الآن يُؤخذ من TokenService الموحّد (لا توكن ثابت بعد الآن).
  String get _token => Get.find<TokenService>().bearer;

//  استدعاء الدالة تلقائياً عند فتح التطبيق أول مرة
  @override
  void onInit() {
    super.onInit();
    fetchStoreAndProducts(); // استدعاء دالة جلب المتجر ومنتجاته
  }

  Future<void> fetchStoreAndProducts() async {
    try {
      isLoading(true);


      final storeData = await _apiCalls.getMerchantStore();


      if (storeData.store != null && storeData.store!.products != null) {

        //  صب منتجات المتجر مباشرة داخل مصفوفة المنتجات التفاعلية
        products.assignAll(storeData.store!.products!);

        print("SUCCESS: Loaded ${products.length} products from store successfully!");
      }
    } catch (e) {
      // بس حطيت هدول مشان نشوف الاخطاء فينا نشيلهم
      print("Error fetching store data and products: $e");
      Get.snackbar("error".tr, "failed_fetch_store".tr);
    } finally {
      isLoading(false);
    }
  }


Future<void> addProduct(dynamic productData) async {
  try {
    isLoading(true);

    // نستخدم الـ Dio الموحّد (الحامل للـ AuthInterceptor) بدل بناء Dio مستقل،
    // فيُحقن التوكن تلقائياً عبر الـ interceptor المشترك.
    final dio = ApiService.dio;

    final response = await dio.post(
      "/products",
      data: productData,
      options: Options(
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    print("STATUS: ${response.statusCode}");
    print("DATA: ${response.data}");

    final product = ProductModel.fromJson(response.data);

    if (product.product != null) {
      products.add(product.product!);
      products.refresh();
      await fetchStoreAndProducts();
    }

    Get.snackbar("success".tr, "product_added".tr);
  } on DioException catch (e) {
    print("STATUS: ${e.response?.statusCode}");
    print("DATA: ${e.response?.data}");
    print("MESSAGE: ${e.message}");

    Get.snackbar("error".tr, ApiService.errorMessage(e, fallback: "failed_to_add_product".tr));
    rethrow;
  } finally {
    isLoading(false);
  }
}

 Future<void> fetchAndFilterProducts({
    int? sub_category_id,
    int? size_id,
    int? color_id,
    double? min_price,
    double? max_price,
    int? page, 
    int? category_id,
  }) async {
    try {
      isFiltering(true);
      final response = await _apiCalls.filterProducts(
        categoryId: category_id,
        subCategoryId: sub_category_id,
        sizeId: size_id,
        colorId: color_id,
        minPrice: min_price,
        maxPrice: max_price,
        page: page,
      );
      filteredProducts.assignAll(response.products ?? []);

      isFilterActive.value = true;

      if (sub_category_id == null &&
          size_id == null &&
          color_id == null &&
          min_price == null &&
          max_price == null) {
        products.assignAll(response.products ?? []);
      }
    } catch (e) {
      Get.snackbar("error".tr, "failed_fetch_products".tr);
    } finally {
      isFiltering(false);
    }
  }

  /// إلغاء الفلترة والرجوع لعرض كل المنتجات
  void clearProductFilters() {
    isFilterActive.value = false;
    filteredProducts.clear();
  }

 Future<void> updateProductInfo({
  required int productId,
  required dynamic productData,
}) async {
  try {
    isLoading(true);

    //  إرسال الطلب واستقبال النتيجة في كائن ProductModel

    final ProductModel productUpdated = await _apiCalls.updateProduct(
      
      productId: productId,
      productData: productData,
    );

   //  البحث عن أندكس المنتج الحالي في الـ RxList
    final index = products.indexWhere((p) => p.id == productId);

    if (index != -1) {
      if (productUpdated.product != null) {
final index = products.indexWhere((p) => p.id == productId);
if (index != -1) {

        products[index] = productUpdated.product!;

        products.refresh();
      }
      }
 //️ إعلام الواجهة بتحديث القائمة
      products.refresh();
    }

    Get.snackbar("success".tr, "product_updated".tr);
  } on DioException catch (e) {

    print("❌ LARAVEL ERROR DETAILS: ${e.response?.data}");
    Get.snackbar("error".tr, ApiService.errorMessage(e, fallback: "failed_to_add_product".tr));
    rethrow;
  } catch (e) {
    print("Error updating product: $e");
    rethrow;
  } finally {
    isLoading(false);
  }
}


  Future<void> removeProduct(int productId) async {
    try {
      isLoading(true);
      await _apiCalls.deleteProduct(
        
        id: productId,
      );

      products.removeWhere((p) => p.id == productId);
      filteredProducts.removeWhere((p) => p.id == productId);
      Get.snackbar("success".tr, "product_deleted".tr);
    } catch (e) {
      Get.snackbar("error".tr, "failed_delete_product".tr);
    } finally {
      isLoading(false);
    }
  }

  //  نقلب الحالة محلياً فوراً، ثم نسترجعها عند الفشل.

  Future<void> toggleProductStatus(int productId) async {
    // نحفظ الحالة الحالية لنسترجعها عند الفشل
    final int iAll = products.indexWhere((p) => p.id == productId);
    final int iFilt = filteredProducts.indexWhere((p) => p.id == productId);
    final dynamic prevAll = (iAll != -1) ? products[iAll].stateProduct : null;
    final dynamic prevFilt = (iFilt != -1) ? filteredProducts[iFilt].stateProduct : null;


    _setLocalState(productId, _flipState(prevAll));
    _setLocalState(productId, _flipState(prevAll), list: filteredProducts);

    try {
      final ProductModel response = await _apiCalls.toggleProductStatus(
       
        id: productId,
      );
      print("✅ toggle-status success: ${response.message}");

      //إذا رجع السيرفر منتجاً نطبّق حالته الموثوقة
      if (response.product != null) {
        _applyStateOnly(response.product!.id, response.product!.stateProduct);
      }

    } on DioException catch (e) {

      print("❌ LARAVEL ERROR DETAILS (toggle-status): ${e.response?.data}");
      // إرجاع الحالة الأصلية اذا فشل الطلب
      _setLocalState(productId, prevAll);
      _setLocalState(productId, prevFilt, list: filteredProducts);
      Get.snackbar("error".tr, ApiService.errorMessage(e, fallback: "status_update_failed".tr));
      rethrow;
    } catch (e) {
      print("Error toggling product status: $e");
      _setLocalState(productId, prevAll);
      _setLocalState(productId, prevFilt, list: filteredProducts);
      Get.snackbar("error".tr, "status_update_failed".tr);
      rethrow;
    }
  }

  
  int _flipState(dynamic current) =>
      (current == 1 || current == "1" || current == true) ? 0 : 1;


  void _setLocalState(int productId, dynamic newState, {RxList? list}) {
    final target = list ?? products;
    final i = target.indexWhere((p) => p.id == productId);
    if (i == -1) return;
    target[i].stateProduct = newState;
    target.refresh();
  }

  /// يضبط الحالة فقط من نسخة السيرفر  
  void _applyStateOnly(int? id, dynamic newState) {
    if (id == null) return;
    _setLocalState(id, newState);
    _setLocalState(id, newState, list: filteredProducts);
  }
}
