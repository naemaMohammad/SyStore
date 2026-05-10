import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
     appBar:   AppBar(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
onPressed: () {
  Get.back();
},
         
        
      ),
       title:  Text(
          'card_page'.tr,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium?.color,
                // استخدم لون النص من الثيم
             fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
           
          ),
        ), bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}