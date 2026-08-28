import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../data/services/api_client.dart';
import '../../data/services/token_service.dart';


class ReportController extends GetxController {
  ReportController({ApiClient? apiClient, TokenService? tokenService})
      : _api = apiClient,
        _tokens = tokenService;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();

  final TokenService? _tokens;
  TokenService get tokens => _tokens ?? Get.find<TokenService>();

  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> reportProduct(int productId, String reason) async {
    if (!await tokens.hasToken) {
      _fail('Please log in to submit a report.');
      return false;
    }
    isSubmitting.value = true;
    try {
      final res = await api.reportProduct({
        'product_id': productId,
        'reason': reason,
      });
      return res.status == true;
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not submit report.');
      return false;
    } catch (_) {
      _fail('Could not submit report.');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<bool> reportStore(int storeId, String reason) async {
    if (!await tokens.hasToken) {
      _fail('Please log in to submit a report.');
      return false;
    }
    isSubmitting.value = true;
    try {
      final res = await api.reportStore({
        'store_id': storeId,
        'reason': reason,
      });
      return res.status == true;
    } on DioException catch (e) {
      _fail(e.message ?? 'Could not submit report.');
      return false;
    } catch (_) {
      _fail('Could not submit report.');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}
