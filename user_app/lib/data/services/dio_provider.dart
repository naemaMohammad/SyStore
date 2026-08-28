import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';

import '../data_source/api_constants.dart';
import 'token_service.dart';

Dio buildDio({TokenService? tokenService, Dio? dioForTesting}) {
  final dio =
      dioForTesting ??
      Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: ApiConstants.defaultTimeout,
          receiveTimeout: ApiConstants.defaultTimeout,
          sendTimeout: ApiConstants.defaultTimeout,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  final tokens = tokenService ?? Get.find<TokenService>();

  dio.interceptors.add(SessionInterceptor(tokenService: tokens));
  dio.interceptors.add(AuthInterceptor(tokenService: tokens));
  dio.interceptors.add(const _LongTimeoutInterceptor());
  dio.interceptors.add(
    LogInterceptor(
      requestBody: kDebugMode,
      responseBody: kDebugMode,
      error: kDebugMode,
    ),
  );

  return dio;
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenService});

  final TokenService tokenService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenService.readToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

class _LongTimeoutInterceptor extends Interceptor {
  const _LongTimeoutInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final wantsLong =
        options.extra['longTimeout'] == true ||
        options.path.contains('/ai-search');

    if (wantsLong) {
      options.receiveTimeout = ApiConstants.aiSearchTimeout;
      options.sendTimeout = ApiConstants.aiSearchTimeout;
    }

    handler.next(options);
  }
}

String? _firstValidationError(Map<String, dynamic> data) {
  final errors = data['errors'];

  if (errors is! Map) return null;

  for (final value in errors.values) {
    if (value is List) {
      for (final item in value) {
        if (item is String && item.trim().isNotEmpty) {
          return item.trim();
        }
      }
    } else if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
  }

  return null;
}

class SessionInterceptor extends Interceptor {
  SessionInterceptor({required this.tokenService});

  final TokenService tokenService;

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final responseData = error.response?.data;

    // ----------------------------------------------------------
    // Validation errors
    // ----------------------------------------------------------
    if (responseData is Map<String, dynamic>) {
      final firstError = _firstValidationError(responseData);

      if (firstError != null) {
        responseData['message'] = firstError;

        handler.next(error.copyWith(message: firstError));
        return;
      }
    }

    final statusCode = error.response?.statusCode;
    final path = error.requestOptions.path;

    final isAuthRequest = path.contains('/login') || path.contains('/register');

    // ----------------------------------------------------------
    // 401 - Unauthorized
    // ----------------------------------------------------------
    if (statusCode == 401) {
      final isLoginRequest = path.contains('/login');

      // ✅ كلمة سر غلط في login → Snackbar فقط
      if (isLoginRequest) {
        await tokenService.clearToken();

        Get.snackbar(
          'error'.tr,
          'Invalid email or password'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        handler.resolve(
          Response<dynamic>(
            requestOptions: error.requestOptions,
            statusCode: 200,
            data: {'message': 'Invalid credentials'},
          ),
        );
        return;
      }

      // ✅ جلسة منتهية في API محمية
      if (!isAuthRequest) {
        await tokenService.clearToken();

        Get.snackbar(
          'session_expired'.tr,
          'session_expired_message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        handler.resolve(
          Response<dynamic>(
            requestOptions: error.requestOptions,
            statusCode: 200,
            data: {'message': 'Session expired'},
          ),
        );
        return;
      }
    }

    // ----------------------------------------------------------
    // 403 - Account blocked
    // ----------------------------------------------------------
    if (statusCode == 403) {
      final message = responseData is Map
          ? responseData['message']?.toString().toLowerCase() ?? ''
          : '';

      final isBlocked =
          message.contains('blocked') ||
          message.contains('محظور') ||
          message.contains('banned') ||
          message.contains('ممنوع');

      if (isBlocked) {
        await tokenService.clearToken();

        _showBlockedDialog();

        handler.resolve(
          Response<dynamic>(
            requestOptions: error.requestOptions,
            statusCode: 200,
            data: {'message': 'Blocked'},
          ),
        );
        return;
      }
    }

    // ----------------------------------------------------------
    // 404 - Not Found
    // ----------------------------------------------------------
    if (statusCode == 404) {
      final message = responseData is Map
          ? responseData['message']?.toString().toLowerCase() ?? ''
          : '';

      final isLoginRequest = path.contains('/login');

      // ✅ إيميل غير موجود في login → Snackbar فقط (مش ديالوغ)
      if (isLoginRequest) {
        await tokenService.clearToken();

        Get.snackbar(
          'error'.tr,
          'Invalid email or password'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        handler.resolve(
          Response<dynamic>(
            requestOptions: error.requestOptions,
            statusCode: 200,
            data: {'message': 'Invalid credentials'},
          ),
        );
        return;
      }

      // ✅ أي 404 خارج login → ديالوغ الحذف
      final isDeleted =
          message.contains('deleted') ||
          message.contains('محذوف') ||
          message.contains('account not found') ||
          message.contains('user not found') ||
          message.contains('merchant not found');

      if (isDeleted) {
        await tokenService.clearToken();

        _showDeletedDialog();

        handler.resolve(
          Response<dynamic>(
            requestOptions: error.requestOptions,
            statusCode: 200,
            data: {'message': 'Deleted'},
          ),
        );
        return;
      }
    }

    handler.next(error);
  }

  // ============================================================
  // BLOCKED DIALOG
  // ============================================================

  void _showBlockedDialog() {
    if (Get.isDialogOpen == true) return;

    final context = Get.context;
    final isDark = context != null
        ? Theme.of(context).brightness == Brightness.dark
        : false;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'account_blocked'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Raleway',
                fontFamilyFallback: ['Cairo'],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'account_blocked_message'.tr,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'contact_support'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF532564),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'okay'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // ============================================================
  // DELETED DIALOG
  // ============================================================

  void _showDeletedDialog() {
    if (Get.isDialogOpen == true) return;

    final context = Get.context;
    final isDark = context != null
        ? Theme.of(context).brightness == Brightness.dark
        : false;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.delete_outline, color: Colors.red, size: 30),
            const SizedBox(width: 10),
            Text(
              'account_deleted'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Raleway',
                fontFamilyFallback: ['Cairo'],
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'account_deleted_message'.tr,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'contact_support'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/start');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF532564),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'okay'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
