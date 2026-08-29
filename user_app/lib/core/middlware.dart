import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final token = box.read('token') as String?;
    if (token == null || token.isEmpty) {
      return const RouteSettings(name: AppRoutes.start);
    }

    return null;
  }
}

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final token = box.read('token') as String?;
    if (token != null && token.isNotEmpty) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
