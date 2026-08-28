import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/data/model/responses.dart';
import 'package:user_app/data/services/cache_service.dart';

import '../../data/model/product_detail_model.dart';
import '../../data/services/api_client.dart';
import 'dart:developer' as developer;


class ProductController extends GetxController {
  ProductController({ApiClient? apiClient}) : _api = apiClient;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();
  final CacheService cache = CacheService.instance;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<ApiProductModel> products = <ApiProductModel>[].obs;
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final RxBool isPaginating = false.obs;

 
  Map<String, dynamic> _lastParams = const {};

  bool get hasMore => currentPage.value < lastPage.value;

  Map<String, dynamic> _cleanParams(Map<String, dynamic> params) {
    final cleaned = <String, dynamic>{};
    params.forEach((key, value) {
      if (value == null) return;
      if (value is String && value.isEmpty) return;
      if (value is List && value.isEmpty) return;
      if (value is Map && value.isEmpty) return;
      cleaned[key] = value;
    });
    return cleaned;
  }


  Future<void> filterProducts(Map<String, dynamic> params) async {
    _lastParams = _cleanParams(params);
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.filterProducts({..._lastParams, 'page': 1});
     
      if (res.status != true) {
        products.clear();
        currentPage.value = 1;
        lastPage.value = 1;
        _fail(res.message ?? 'Could not load products.');
        return;
      }
      _applyFirstPage(res);
    } on DioException catch (e) {
      products.clear();
      _fail(e.message ?? 'Could not load products.');
    } catch (_) {
      products.clear();
      _fail('Could not load products.');
    } finally {
      isLoading.value = false;
    }
  }

 
  Future<void> loadMore() async {
    if (!hasMore || isPaginating.value) return;
    final nextPage = currentPage.value + 1;
    isPaginating.value = true;
    try {
      final res = await api.filterProducts({..._lastParams, 'page': nextPage});
      if (res.status != true) {
        _fail(res.message ?? 'Could not load more products.');
        return;
      }
      final page = res.data;
      if (page != null) {
        products.addAll(page.data ?? const []);
        currentPage.value = page.currentPage ?? nextPage;
        lastPage.value = page.lastPage ?? lastPage.value;
      }
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not load more products.');
    } catch (_) {
      _fail('Could not load more products.');
    } finally {
      isPaginating.value = false;
    }
  }

  void _applyFirstPage(FilterResponse res) {
    final page = res.data;
   
    products.value = page?.data ?? const [];
    currentPage.value = page?.currentPage ?? 1;
    lastPage.value = page?.lastPage ?? 1;
  }

  final RxList<ApiProductModel> topProducts = <ApiProductModel>[].obs;
Future<void> getTopProducts({bool forceRefresh = false}) async {
  if (isLoading.value) return;

  isLoading.value = true;
  errorMessage.value = '';

  try {
    if (!forceRefresh) {
      final cachedData = cache.read<List>('top_products_cache');
      final expired = cache.isExpired(
        'top_products_cache',
        const Duration(minutes: 5),
      );

      if (cachedData != null && !expired) {
        topProducts.value = cachedData
            .map((e) =>
                ApiProductModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        developer.log('Loaded top products from cache');
        isLoading.value = false;
        return;
      }
    }

    final res = await api.topRatedProducts();
    topProducts.value = res.products ?? [];

    cache.save(
      'top_products_cache',
      topProducts.map((e) => e.toJson()).toList(),
    );

    developer.log('Loaded top products from API and cached');
  } on DioException catch (e) {
    _fail(e.message ?? 'Could not load top products.');
  } catch (_) {
    _fail('Could not load top products.');
  } finally {
    isLoading.value = false;
  }
}
Future<void> goToPage(int page) async {
  if (page < 1 || page > lastPage.value) return;
  if (page == currentPage.value) return;
  if (isLoading.value) return;

  isLoading.value = true;
  errorMessage.value = '';

  try {
    final res = await api.filterProducts({
      ..._lastParams,
      'page': page,
    });

    if (res.status != true) {
      _fail(res.message ?? 'Could not load products.');
      return;
    }

    final pageData = res.data;

    products.value = pageData?.data ?? const [];

    currentPage.value = pageData?.currentPage ?? page;
    lastPage.value = pageData?.lastPage ?? lastPage.value;
  } on DioException catch (e) {
    _fail(e.message ?? 'Could not load products.');
  } catch (_) {
    _fail('Could not load products.');
  } finally {
    isLoading.value = false;
  }
}

  final Rx<ProductDetailModel?> productDetail = Rx<ProductDetailModel?>(null);

  Future<void> getProduct(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await api.getProduct(id);
      productDetail.value = res.product;
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not load this product.');
    } catch (_) {
      _fail('Could not load this product.');
    } finally {
      isLoading.value = false;
    }
  }

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
