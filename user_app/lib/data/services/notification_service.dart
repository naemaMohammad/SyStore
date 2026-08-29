import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/core/theme/color.dart';

class NotificationService {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final box = GetStorage();

  static Future<void> initialize() async {
    try {
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      String? token = await messaging.getToken();
      print("🪙 USER FCM TOKEN: $token");

      if (token != null && token.isNotEmpty) {
        box.write('fcm_token', token);
        print('✅ FCM Token saved to storage: $token');
      } else {
        print('⚠️ FCM Token is null or empty, using temporary token');
        String tempToken = 'temp_token_${DateTime.now().millisecondsSinceEpoch}';
        box.write('fcm_token', tempToken);
        print('✅ Temporary token saved: $tempToken');
      }
    } catch (e) {
      print('❌ Notification Service Error: $e');
      String tempToken = 'temp_token_${DateTime.now().millisecondsSinceEpoch}';
      box.write('fcm_token', tempToken);
      print('✅ Fallback temporary token saved: $tempToken');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 User Notification (Foreground): ${message.notification?.title}");
      _handleNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 User Notification (Opened): ${message.notification?.title}");
      _handleNotification(message, isFromBackground: true);
    });

    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print("📩 User Notification (Initial): ${initialMessage.notification?.title}");
      _handleNotification(initialMessage, isFromBackground: true);
    }
  }

  static Future<String?> getFcmTokenFromFirebase() async {
    try {
      final token = await messaging.getToken();
      print('🔑 FCM Token from Firebase: $token');
      return token;
    } catch (e) {
      print('❌ Error getting FCM token: $e');
      return null;
    }
  }

  static void _handleNotification(RemoteMessage message, {bool isFromBackground = false}) {
    final data = message.data;
    final type = data['type'] ?? data['notification_type'];
    final title = message.notification?.title ?? 'Notification';
    final body = message.notification?.body ?? '';

    print("📩 User Notification Type: $type");

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

    if (isFromBackground) {
      _navigateToScreen(type);
    }
  }

  static void _navigateToScreen(String type) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(AppRoutes.home);
      
      try {
        final mainController = Get.find<MainLayoutController>();
        mainController.changeTab(2);
      } catch (e) {
        print('⚠️ MainLayoutController not found: $e');
      }
    });
  }

  static String? getFcmToken() {
    return box.read('fcm_token');
  }
}

@pragma('vm:entrypoint')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("📩 User Notification (Background): ${message.notification?.title}");
  final box = GetStorage();
  box.write('pending_notification', {
    'title': message.notification?.title,
    'body': message.notification?.body,
    'data': message.data,
    'type': message.data['type'] ?? message.data['notification_type'],
  });
}