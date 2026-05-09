// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:user_app/core/routes.dart';
// import 'package:user_app/core/theme/theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.light(),
//       darkTheme: AppTheme.dark(),
//       themeMode: ThemeMode.system,
//       initialRoute: '/orderproduct',
//       getPages: AppPages.pages,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_app/core/routes.dart';
import 'package:user_app/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
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
      //translations: MyTranslation(),
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
      initialRoute: '/orders',
      getPages: AppPages.pages,
    );
  }
}
