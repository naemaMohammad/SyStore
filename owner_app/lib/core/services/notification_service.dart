import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static Future<void> initialize() async {

    FirebaseMessaging messaging =
        FirebaseMessaging.instance;


    await messaging.requestPermission();


    String? token =
        await messaging.getToken();


    print("OWNER FCM TOKEN: $token");


    FirebaseMessaging.onMessage.listen((message){

      print(
        "OWNER Notification: ${message.notification?.title}"
      );

    });

  }
}