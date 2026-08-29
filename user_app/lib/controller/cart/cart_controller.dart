import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/services/api_client.dart';
import '../../data/services/token_service.dart';

enum AddToCartResult {
  added,
  declined,

  noVariant,
  unauthenticated,
  failed,
}


class CartController extends GetxController {
  CartController({ApiClient? apiClient, TokenService? tokenService})
      : _api = apiClient,
        _tokens = tokenService;

  final ApiClient? _api;
  ApiClient get api => _api ?? Get.find<ApiClient>();

  final TokenService? _tokens;
  TokenService get tokens => _tokens ?? Get.find<TokenService>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool checking = false.obs;
  final RxBool adding = false.obs;

  final RxBool? sameStore = RxBool(true);

  final RxString message = ''.obs;

 
  final RxnInt currentCartStoreId = RxnInt();


  final RxInt cartItemCount = 0.obs;

 
  final RxList<Map<String, dynamic>> cartItems =
      <Map<String, dynamic>>[].obs;

  int get totalQuantity {
    var sum = 0;
    var counted = 0;
    for (final row in cartItems) {
      final lineQty = _lineItemQuantity(row);
      if (lineQty != null) {
        sum += lineQty;
      } else {
        counted++;
      }
    }
    return sum > 0 ? sum : counted;
  }

  bool get cartHasItems => cartItemCount.value > 0;

  
  Future<bool?> checkStore(int productVariantId) async {
    if (!await tokens.hasToken) {
      _fail('cart_login_required'.tr);
      return null;
    }
    checking.value = true;
    try {
      final res = await api.checkStore({'product_variant_id': productVariantId});
      sameStore?.value = res.sameStore ?? true;
      message.value = res.message ?? '';
      return res.sameStore;
    } on DioException catch (e) {
      _logDioError('check-store', e);
      _fail(_dioErrorMessage(e, 'cart_check_failed'.tr));
      return null;
    } catch (e, s) {
      debugPrint('cart check-store error: $e\n$s');
      _fail('cart_check_failed'.tr);
      return null;
    } finally {
      checking.value = false;
    }
  }


  Future<bool> addToCart(int productVariantId, int quantity) async {
    if (!await tokens.hasToken) {
      _fail('cart_login_required'.tr);
      return false;
    }
    adding.value = true;
    try {
      final res = await api.addToCart({
        'product_variant_id': productVariantId,
        'quantity': quantity,
      });
      _applyCartFromResponse(res.cart);
      Get.snackbar('cart_added'.tr, 'cart_added_msg'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return true;
    } on DioException catch (e) {
      _logDioError('add', e);
      _fail(_dioErrorMessage(e, 'cart_add_failed'.tr));
      return false;
    } catch (e, s) {
      debugPrint('cart add error: $e\n$s');
      _fail('cart_add_failed'.tr);
      return false;
    } finally {
      adding.value = false;
    }
  }


  void _applyCartFromResponse(Map<String, dynamic>? cart) {
    if (cart == null) return;
    final variants = cart['variants'];
    if (variants is List) {
      int sum = 0;
      int counted = 0;
      final rows = <Map<String, dynamic>>[];
      for (final v in variants) {
        if (v is Map<String, dynamic>) {
          rows.add(v);
          final lineQty = _lineItemQuantity(v);
          if (lineQty != null) {
            sum += lineQty;
            continue;
          }
        }
        counted++;
      }
      cartItemCount.value = sum > 0 ? sum : counted;
      cartItems
        ..clear()
        ..addAll(rows);
    }
  }

  
  static int? _lineItemQuantity(Map<String, dynamic> row) {
    final pivot = row['pivot'];
    if (pivot is Map<String, dynamic>) {
      final q = pivot['quantity'];
      if (q is num) return q.toInt();
    }
    final top = row['quantity'];
    if (top is num) return top.toInt();
    return null;
  }


  Future<bool> clearCart() async {

    if (!await tokens.hasToken) {
      _fail('cart_login_required'.tr);
      return false;
    }
    try {
      await api.clearCart();
      _resetLocalCart();
      return true;
    } on DioException catch (e) {
      _logDioError('clear', e);
      _fail(_dioErrorMessage(e, 'cart_clear_failed'.tr));
      return false;
    } catch (e, s) {
      debugPrint('cart clear error: $e\n$s');
      _fail('cart_clear_failed'.tr);
      return false;
    }
  }

 
Future<AddToCartResult> addVariantToCart({
  required int productVariantId,
  required int quantity,
  required Future<bool> Function() confirmClear,
  int? storeId,
}) async {
  if (!await tokens.hasToken) return AddToCartResult.unauthenticated;

  final same = await checkStore(productVariantId);
  if (same == null) return AddToCartResult.failed;

  if (!same) {
    final confirmed = await confirmClear();
    if (!confirmed) return AddToCartResult.declined;
    final cleared = await clearCart();
    if (!cleared) return AddToCartResult.failed;
  }

  final ok = await addToCart(productVariantId, quantity);
  if (ok) {
    if (storeId != null) {
      currentCartStoreId.value = storeId;
    }
    return AddToCartResult.added;
  }
  return AddToCartResult.failed;
}


  void _resetLocalCart() {
    currentCartStoreId.value = null;
    cartItemCount.value = 0;
    cartItems.clear();
  }

 
  String _dioErrorMessage(DioException e, String fallbackKey) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'cart_no_connection'.tr;
      case DioExceptionType.connectionError:
        return 'cart_no_connection'.tr;
      case DioExceptionType.badResponse:
       
        final status = e.response?.statusCode;
        if (status == 400 || status == 422) {
          final data = e.response?.data;
          if (data is Map<String, dynamic>) {
            final msg = data['message'];
            if (msg is String && msg.trim().isNotEmpty) {
              return msg;
            }
          } else if (data is String && data.trim().isNotEmpty) {
            return data;
          }
        }
        return fallbackKey.tr;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
      default:
        return fallbackKey.tr;
    }
  }

  void _logDioError(String op, DioException e) {
    debugPrint(
      'cart $op failed: type=${e.type} status=${e.response?.statusCode} '
      'message=${e.message} data=${e.response?.data}',
    );
  }

  void _fail(String message) {
    errorMessage.value = message;
    Get.snackbar('cart_error'.tr, message, snackPosition: SnackPosition.BOTTOM);
  }
}
