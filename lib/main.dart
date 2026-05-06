import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:user_app/core/localization/translation.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lana/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Locale locale;
    if (box.read('lang') != null) {
      locale = Locale(box.read('lang'));
    } else {
      locale = Get.deviceLocale ?? const Locale('en');
    }
    String theme = box.read('theme') ?? 'system';
    ThemeMode themeMode;
    if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.system;
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      translations: MyTranslation(),
      locale: locale,
      fallbackLocale: const Locale('en'),
      builder: (context, child) {
        return Directionality(
          textDirection: locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: Start(),
    );
  }
}
