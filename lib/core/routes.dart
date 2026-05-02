import 'package:get/get.dart';
import 'package:user_app/core/binding/myOrderBinding.dart';
import 'package:user_app/view/ranim/screen/MyOrder.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: '/orders',
      page: () => const Myorder(),
      binding: OrdersBinding(),
    ),
  ];
}