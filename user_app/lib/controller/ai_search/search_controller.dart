import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/data/model/responses.dart';

import '../../data/services/api_client.dart';


class SearchController extends GetxController {
  SearchController({ApiClient? apiClient}) : _api = apiClient;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();

  final RxBool isSearching = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<AiFiltersModel?> filters = Rx<AiFiltersModel?>(null);
  final RxList<ApiProductModel> results = <ApiProductModel>[].obs;

  Future<void> aiSearch(String query) async {
    if (query.trim().isEmpty) {
      _fail('search_empty_query'.tr);
      return;
    }

    isSearching.value = true;
    errorMessage.value = '';
    filters.value = null;
    results.clear();

    try {
      final res = await api.aiSearch(
        {'query': query},
        extras: const {'longTimeout': true},
      );
      filters.value = res.filters;
      results.value = res.products ?? const [];

    } on DioException catch (e) {
  
      _logDioError(e);
      _fail(_dioErrorMessage(e));
    } catch (e, s) {
      debugPrint('AI search unexpected error: $e\n$s');
      _fail('search_failed'.tr);
    } finally {
      isSearching.value = false;
    }
  }

 
  String _dioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'search_timeout'.tr;
      case DioExceptionType.connectionError:
        return 'search_no_connection'.tr;
      case DioExceptionType.badResponse:
       
        return 'search_failed'.tr;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        return 'search_failed'.tr;
    }
  }

  void _logDioError(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    debugPrint(
      'AI search failed: type=${e.type} status=$status '
      'message=${e.message} data=$data',
    );
  }

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar(
      'search_error'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}

