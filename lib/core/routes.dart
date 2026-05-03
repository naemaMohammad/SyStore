import 'package:get/get.dart';
import 'package:user_app/core/binding/EditorderBinding.dart';
import 'package:user_app/core/binding/ShowMyCartBinding.dart';
import 'package:user_app/core/binding/myOrderBinding.dart';
import 'package:user_app/view/ranim/screen/MyOrder.dart';
import 'package:user_app/view/ranim/screen/ShowMyCart.dart';
import 'package:user_app/view/ranim/screen/editOrder.dart';

import '../view/ranim/screen/order.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: '/orders',
      page: () => const Myorder(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: '/showorder',
      page: () => const Showmycart(),
      binding: Mycartbinding(),
    ),
    GetPage(
      name: '/editorder',
      page: () => const Editorder(),
      binding: Editorderbinding(),
    ),
    GetPage(
      name: '/orderproduct',
      page: () => const Order(),
      binding: Editorderbinding(),
    ),
  ];
}