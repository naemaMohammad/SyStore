import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_app/controller/settings/settings_controller.dart';
import 'package:user_app/core/binding/api_bindings.dart';
import 'package:user_app/core/localization/translation.dart';
import 'package:user_app/core/routes/app_pages.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/services/notification_service.dart';
import 'package:user_app/data/services/token_service.dart';
import 'package:user_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── 1. Local Storage 
  await GetStorage.init();
  debugPrint('✅ GetStorage initialized');

  // ── 2. Firebase Initialization
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized');
  } catch (e) {
    debugPrint('⚠️ Firebase init skipped (non-essential): $e');
  }

  // ── 3. Notifications 
  try {
    await NotificationService.initialize();
    debugPrint('✅ NotificationService initialized');
  } catch (e) {
    debugPrint('⚠️ NotificationService init skipped: $e');
  }

  // ── 4. Register API Bindings 
  ApiBindings().dependencies();

  // ── 5. Load persisted theme & locale & user data 
  final box = GetStorage();
  final fcmToken = box.read('fcm_token');
  debugPrint('📱 Current FCM Token: $fcmToken');
  debugPrint('📱 Send this token to your backend team');
  final savedTheme = box.read('theme') as String?;
  final savedLang = box.read('lang') as String?;
  final userData = box.read('user_data') as Map<String, dynamic>?;

  // ── 6. Determine initial route based on auth token
  final tokenService = Get.find<TokenService>();
  final token = await tokenService.readToken();
  final hasToken = token != null && token.isNotEmpty;
  
  final String initialRoute;
  if (hasToken) {
    initialRoute = AppRoutes.home;
    debugPrint('✅ Auth token found -> navigating to Home');
  } else {
    initialRoute = AppRoutes.start;
    debugPrint('ℹ️ No auth token -> navigating to Start');
  }

  debugPrint('✅ Saved theme: $savedTheme');
  debugPrint('✅ Has user data: ${userData != null}');

  runApp(
    SyStoreApp(
      initialTheme: savedTheme,
      initialLang: savedLang,
      initialRoute: initialRoute,
      userData: userData,
    ),
  );
}

class SyStoreApp extends StatelessWidget {
  final String? initialTheme;
  final String? initialLang;
  final String initialRoute;
  final Map<String, dynamic>? userData;

  const SyStoreApp({
    super.key,
    this.initialTheme,
    this.initialLang,
    required this.initialRoute,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    Locale? initialLocale;
    if (initialLang != null) {
      initialLocale = Locale(initialLang!);
    }
    ThemeMode initialMode = ThemeMode.system;
    if (initialTheme == 'light') {
      initialMode = ThemeMode.light;
    } else if (initialTheme == 'dark') {
      initialMode = ThemeMode.dark;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userData != null) {
        try {
          final controller = Get.find<SettingsController>();
          controller.loadUserData(userData!);
          debugPrint('✅ User data loaded into SettingsController');
        } catch (e) {
          debugPrint('⚠️ SettingsController not ready yet: $e');
        }
      }
    });

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STORIA',
      translations: MyTranslation(),
      locale: initialLocale ?? Get.deviceLocale,
      fallbackLocale: const Locale('en'),
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: initialMode,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}