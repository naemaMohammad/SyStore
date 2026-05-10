import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user_app/controller/lilav/main_layout_controller.dart';
import 'package:user_app/view/lilav/Sreens/Card_page.dart'; 
import 'package:user_app/view/lilav/Sreens/Favorite_page.dart';
import 'package:user_app/view/lilav/Sreens/profile_page.dart';
import 'package:user_app/view/lilav/widgets/bottom_nav.dart';
import 'home_page.dart';


class MainLayout extends StatelessWidget {
   MainLayout({super.key});

    final controller = Get.put(MainLayoutController());

  final List<Widget> pages = [
    Home(),
     FavoritesPage(),
    const CardPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      backgroundColor: Colors.white,
      body: pages[controller.currentIndex.value],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab ,
      ),)
    );
  } 
}

