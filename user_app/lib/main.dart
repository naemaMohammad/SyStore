import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/core/localization/translation.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lana/hello/start.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  if (box.read('lang') == null) {
    String deviceLang =
        Get.deviceLocale?.languageCode ?? 'en';
    box.write('lang', deviceLang);
  }
  if (box.read('theme') == null) {
    Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      box.write('theme', 'dark');
    } else {
      box.write('theme', 'light');
    }
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Locale locale = Locale(box.read('lang'));
    String theme = box.read('theme');
    ThemeMode themeMode;
    if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
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