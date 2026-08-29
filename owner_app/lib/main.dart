import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/binding/InitialBinding.dart';
import 'package:owner_app/core/localization/translation.dart';
import 'package:owner_app/core/routes/app_pages.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/core/theme/theme.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/data/services/auth_check_service.dart';
import 'package:owner_app/data/services/notification_service.dart';
import 'package:owner_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print(' Firebase initialized');
  } catch (e) {
    print(' Firebase Error: $e');
  }
  await GetStorage.init();
  print(' GetStorage initialized');
  final box = GetStorage();
  print('========== APP START ==========');
  print('Stored token: ${box.read('token')}');
  print('All storage: ${box.getKeys()}');
  print('===============================');

  try {
    await NotificationService.initialize();
    print('✅ Notification Service initialized');
  } catch (e) {
    print('❌ Notification Service Error: $e');
  }

  try {
    await ApiService.init();
    print('✅ API Service initialized');
  } catch (e) {
    print('❌ API Service Error: $e');
  }
  if (box.read('lang') == null) {
    String deviceLang = Get.deviceLocale?.languageCode ?? 'en';
    box.write('lang', deviceLang);
  }

  if (box.read('theme') == null) {
    Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    box.write('theme', brightness == Brightness.dark ? 'dark' : 'light');
  }
  final initialRoute = await AuthCheckService.getInitialRoute();
  _handlePendingNotification(box);
  print('🚀 Initial Route: $initialRoute');

  runApp(MyApp(initialRoute: initialRoute));
}

void _handlePendingNotification(GetStorage box) {
  final pendingNotification = box.read('pending_notification');
  if (pendingNotification == null) return;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.snackbar(
      pendingNotification['title'] ?? 'Notification',
      pendingNotification['body'] ?? '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  });
  box.remove('pending_notification');
}

// ========================================================
class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Locale locale = Locale(box.read('lang') ?? 'en');
    String theme = box.read('theme') ?? 'light';
    ThemeMode themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      initialBinding: InitialBinding(),
      translations: MYTranslation(),
      locale: locale,
      fallbackLocale: const Locale('en'),
      initialRoute: initialRoute,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      builder: (context, child) {
        return Directionality(
          textDirection: locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
