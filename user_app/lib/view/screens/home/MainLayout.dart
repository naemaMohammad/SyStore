import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/view/screens/favorite/Favorite_page.dart';
import 'package:user_app/view/screens/orders/viewOrders.dart';
import 'package:user_app/view/screens/settings/settings.dart';
import 'package:user_app/view/widgets/home_widgets/bottom_nav.dart';

import 'home_page.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final controller = Get.find<MainLayoutController>();

  final List<Widget> pages = [Home(), FavoritesPage(), Myorder(), Settings()];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        if (controller.currentIndex.value != 0) {
          controller.changeTab(0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.white,
          body: pages[controller.currentIndex.value],
          bottomNavigationBar: CustomBottomNav(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
          ),
        ),
      ),
    );
  }
}
