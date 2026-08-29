// lib/app/data/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/data_source/api_call.dart';
import 'package:owner_app/data/data_source/api_calls.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/data_source/merchant_api.dart';
import 'package:owner_app/data/services/token_service.dart';

final getIt = GetIt.instance;

/// Unified API layer.
///
/// After the merge, three separate Dio/retrofit stacks existed (lana MerchantApi,
/// lilav ApiCalls, ranim ApiCall), each with its own base URL and token handling,
/// and `init()` was never called. This service is now the single owner of:
///   - one Dio instance (shared by every retrofit client),
///   - the [AuthInterceptor] that injects the token from [TokenService],
///   - registration of all three retrofit clients in [getIt] + GetX.
///
/// Call `ApiService.init()` once at startup (see main.dart) before any
/// controller or route binding runs.
class ApiService {
  static late Dio dio;

  static Future<void> init() async {
    // Ensure TokenService is available to the interceptor.
    if (!Get.isRegistered<TokenService>()) {
      Get.put(TokenService(), permanent: true);
    }

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    // Single Dio backs every retrofit client so the token interceptor applies
    // to all requests and no controller ever builds its own Dio.
    Get.put<Dio>(dio, permanent: true);

    getIt.registerLazySingleton<MerchantApi>(() => MerchantApi(dio));
    getIt.registerLazySingleton<ApiCall>(() => ApiCall(dio));
    getIt.registerLazySingleton<ApiCalls>(() => ApiCalls(dio));
  }

  static MerchantApi get merchantApi => getIt<MerchantApi>();
  static ApiCall get apiCall => getIt<ApiCall>();
  static ApiCalls get apiCalls => getIt<ApiCalls>();

  static String errorMessage(Object error, {String? fallback}) {
    if (error is DioException) {
      final validationMessage = _laravelValidationMessage(error.response?.data);
      if (validationMessage != null) return validationMessage;

      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        final message = data['message'].toString().trim();
        if (message.isNotEmpty) return message;
      }
    }

    return fallback ?? 'An error occurred. Please try again.'.tr;
  }

  static String? _laravelValidationMessage(dynamic data) {
    if (data is! Map) return null;

    final errors = data['errors'];
    if (errors is Map) {
      final messages = <String>[];
      for (final fieldErrors in errors.values) {
        if (fieldErrors is List) {
          messages.addAll(
            fieldErrors
                .map((message) => message.toString().trim())
                .where((message) => message.isNotEmpty),
          );
        } else if (fieldErrors != null) {
          final message = fieldErrors.toString().trim();
          if (message.isNotEmpty) messages.add(message);
        }
      }
      if (messages.isNotEmpty) return messages.join('\n');
    }

    final message = data['message']?.toString().trim();
    return message == null || message.isEmpty ? null : message;
  }
}

/// Injects the merchant token into every request and handles the global
/// 401 (session expired) / 403 (blocked) / 404 (deleted) responses.
///
/// This consolidates the inline interceptor that previously lived in
/// `ApiService.init()` so the same auth behavior applies to lilav and ranim
/// requests too (which previously had no error handling at all).
class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = Get.find<TokenService>().bearer;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = token;
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    // 401 — only for protected requests (not login/register).
    if (statusCode == 401) {
      final path = err.requestOptions.path;
      final isAuthRequest =
          path.contains('/login') || path.contains('/register');
      if (!isAuthRequest) {
        Get.find<TokenService>().clear();
        Get.snackbar(
          'session_expired'.tr,
          'session_expired_message'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAllNamed(AppRoutes.start);
      }
      return handler.next(err);
    }

    // 403 — merchant blocked.
    if (statusCode == 403) {
      final data = err.response?.data;
      final message =
          (data is Map ? data['message']?.toString().toLowerCase() : '') ?? '';
      if (message.contains('blocked') ||
          message.contains('محظور') ||
          message.contains('banned') ||
          message.contains('ممنوع')) {
        Get.find<TokenService>().clear();
        _showAccountDialog(
          titleKey: 'account_blocked',
          messageKey: 'account_blocked_message',
        );
      }
      return handler.next(err);
    }

    // 404 — merchant deleted.
    if (statusCode == 404) {
      final data = err.response?.data;
      final message =
          (data is Map ? data['message']?.toString().toLowerCase() : '') ?? '';
      if (message.contains('not found') ||
          message.contains('غير موجود') ||
          message.contains('deleted') ||
          message.contains('محذوف')) {
        Get.find<TokenService>().clear();
        _showAccountDialog(
          titleKey: 'account_deleted',
          messageKey: 'account_deleted_message',
        );
      }
      return handler.next(err);
    }

    return handler.next(err);
  }

  void _showAccountDialog({
    required String titleKey,
    required String messageKey,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            const SizedBox(width: 10),
            Text(
              titleKey.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messageKey.tr, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(
              'contact_support'.tr,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(AppRoutes.start);
            },
            child: Text(
              'okay'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
