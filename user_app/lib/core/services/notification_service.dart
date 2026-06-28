import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static Future<void> initialize() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // طلب صلاحية الإشعارات
    NotificationSettings settings =
        await messaging.requestPermission();

    print(
      'Permission: ${settings.authorizationStatus}',
    );


    // جلب التوكن
    String? token = await messaging.getToken();

    print('FCM TOKEN: $token');


    // استقبال إشعار والتطبيق مفتوح
    FirebaseMessaging.onMessage.listen((message) {

      print(
        'Notification received: ${message.notification?.title}',
      );

    });

  }
}