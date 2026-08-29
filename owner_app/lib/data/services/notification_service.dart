import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/view/screen/auth/login.dart';
import 'package:owner_app/view/screen/order/order.dart';
import 'package:owner_app/view/screen/order/orderDetails.dart';
import 'package:owner_app/view/screen/start/start.dart';

class NotificationService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final box = GetStorage();

  static Future<void> initialize() async {
    await messaging.requestPermission(alert: true, badge: true, sound: true);

    String? token = await messaging.getToken();
    print("🪙 OWNER FCM TOKEN: $token");

    if (token != null && token.isNotEmpty) {
      box.write('fcm_token', token);
      print('✅ FCM Token saved to GetStorage: $token');
    } else {
      print('❌ FCM Token is null or empty');
      box.write('fcm_token', 'test_token_123');
    }

    // ✅ 1. التطبيق مفتوح
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Owner Notification (Foreground): ${message.notification?.title}");
      _handleNotification(message);
    });

    // ✅ 2. التطبيق في الخلفية
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // ✅ 3. الضغط على الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 Owner Notification (Opened): ${message.notification?.title}");
      _handleNotification(message, isFromBackground: true);
    });

    // ✅ 4. التطبيق مغلق
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print("📩 Owner Notification (Initial): ${initialMessage.notification?.title}");
      _handleNotification(initialMessage, isFromBackground: true);
    }
  }

  static void _handleNotification(
    RemoteMessage message, {
    bool isFromBackground = false,
  }) {
    final data = message.data;
    final type = data['type'] ?? data['notification_type'];
    final title = message.notification?.title ?? 'Notification';
    final body = message.notification?.body ?? '';
    
    // ✅ استخراج order_id إذا وجد
    final orderId = data['order_id'] ?? data['orderId'];

    print("📩 Owner Notification Type: $type");
    print("📩 Order ID: $orderId");

    // ✅ عرض Snackbar فقط إذا كان التطبيق مفتوح
    if (!isFromBackground) {
      Get.snackbar(
        title,
        body,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(10),
        borderRadius: 12,
      );
    }

    // ✅ التنقل عند الضغط على الإشعار (من الخلفية أو عند فتح التطبيق)
    if (isFromBackground) {
      _navigateToScreen(type, orderId: orderId);
    }
  }

  static void _navigateToScreen(String type, {String? orderId}) {
    print("🔍 Navigating to: $type (orderId: $orderId)");

    switch (type) {
      // ✅ 1. تم قبول المتجر → يروح لصفحة الإعدادات
      case 'merchant_approved':
        if (Get.isDialogOpen ?? false) Get.back();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAll(() => const Login(), transition: Transition.fade);
        });
        break;

      // ✅ 2. تم رفض المتجر → يروح لشاشة البداية
      case 'merchant_rejected':
        if (Get.isDialogOpen ?? false) Get.back();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAll(() => const Start(), transition: Transition.fade);
        });
        break;

      // ✅ 3. طلب جديد → يروح لصفحة الطلبات
      case 'new_order':
        Get.offAll(() => const OrdersView(), transition: Transition.fade);
        break;

      // ✅ 4. تم تقييم الطلب → يروح لتفاصيل الطلب
      case 'order_rated':
        if (orderId != null && orderId.isNotEmpty) {
          Get.offAll(
            () => Orderdetails(),
            arguments: int.tryParse(orderId),
            transition: Transition.fade,
          );
        } else {
          Get.offAll(() => const OrdersView(), transition: Transition.fade);
        }
        break;

      default:
        print("⚠️ Unknown notification type: $type");
        break;
    }
  }

  static String? getFcmToken() {
    return box.read('fcm_token');
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("📩 Owner Notification (Background): ${message.notification?.title}");
  final box = GetStorage();
  
  final data = message.data;
  final orderId = data['order_id'] ?? data['orderId'];
  
  box.write('pending_notification', {
    'title': message.notification?.title,
    'body': message.notification?.body,
    'data': message.data,
    'type': data['type'] ?? data['notification_type'],
    'order_id': orderId,
  });
}