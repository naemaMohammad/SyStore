import 'package:flutter/material.dart';
import 'package:user_app/core/theme/theme.dart';
// <<<<<<< HEAD
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:user_app/core/routes.dart';
// =======
// import 'package:user_app/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}





/*import 'package:flutter/material.dart';
>>>>>>> ebba681a60b3bf4975408133b16e7f94b522f12e

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/orderproduct',
      getPages: AppPages.pages,
    );
  }
}
*/