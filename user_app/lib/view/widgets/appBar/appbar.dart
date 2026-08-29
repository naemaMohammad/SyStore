import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';

class SettingsAppBar extends StatelessWidget {
  final String title;

  const SettingsAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 66,
      elevation: 0,
      scrolledUnderElevation: 0,

      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        onPressed: () => Get.find<MainLayoutController>().changeTab(0),
      ),

      title: Text(
        title.tr,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontFamilyFallback: ['Cairo'],
          fontWeight: FontWeight.w700,
          fontSize: 23,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(6),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 1)],
          ),
        ),
      ),
    );
  }
}
