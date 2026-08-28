// lib/core/services/auth_check_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/services/api_service.dart';

class AuthCheckService {
  static final box = GetStorage();

  /// ✅ التحقق من حالة التاجر عند فتح التطبيق
  static Future<String> getInitialRoute() async {
    final token = box.read('token');

    // إذا ما في توكن → ابدأ من شاشة البداية
    if (token == null || token.toString().isEmpty) {
      return AppRoutes.start;
    }

    try {
      final response = await ApiService.merchantApi.getStore();
      final storeData = response is Map ? response : null;

      // ✅ إذا كان التاجر محظور
      if (storeData != null &&
          (storeData['is_blocked'] == true || storeData['blocked'] == true)) {
        _clearSession();
        _showBlockedDialog();
        return AppRoutes.start;
      }

      // ✅ كل شيء طبيعي
      return AppRoutes.mainScaffold;
    } catch (e) {
      // ✅ معالجة أخطاء الـ API
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          // ✅ حظر
          _clearSession();
          _showBlockedDialog();
          return AppRoutes.start;
        } else if (e.response?.statusCode == 404) {
          // ✅ حذف
          _clearSession();
          _showDeletedDialog();
          return AppRoutes.start;
        } else if (e.response?.statusCode == 401) {
          // ✅ توكن منتهي
          _clearSession();
          return AppRoutes.start;
        }
      }

      // ✅ في حالات خطأ أخرى، نعتبر التاجر مسجل دخول
      return AppRoutes.mainScaffold;
    }
  }

  // ============================================================
  // ✅ دوال مساعدة
  // ============================================================

  static void _clearSession() {
    box.remove('token');
    box.remove('user_data');
  }

  static void _showBlockedDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'contact_support'.tr,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'okay'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void _showDeletedDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'account_deleted'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
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
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'contact_support'.tr,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'okay'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}