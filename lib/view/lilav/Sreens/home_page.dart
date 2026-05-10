import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/lilav/widgets/stores_section.dart.dart';
import 'package:user_app/view/lilav/widgets/AdsCarousel.dart';
import 'package:user_app/view/lilav/widgets/categories_widget.dart';
import 'package:user_app/view/lilav/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
     final bool isDark =
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: AppColors.primary,
      appBar: AppBar(
        toolbarHeight: 45,
       backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        
        title:  Text(
          'home_title'.tr, 
          style: 
           Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: AppFonts.heading(),
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
               color: isDark
                    ? AppColors.textDarkHome
                    : AppColors.white,
              
          ),
        ),
        leading:  Icon(
          Icons.circle_notifications,
          color: Theme.of(context).appBarTheme.foregroundColor,
          size: 30,
        ),
      ),
      body:
      //هاد container عملتو مشان حواف ال appbar تكون منحنية متل التصميم، وبعدين حطيت كل المحتوى داخل SingleChildScrollView مشان الصفحة تكون scrollable
       Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
             color: isDark
              ? AppColors.backgroundSecondaryDarkHome
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(35),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 20, right: 8),
            child: Column(
              children: [
               
                const SizedBox(height: 15), 
                   MySearchBar(),
                const SizedBox(height: 15),
                AdsCarousel(),
                const SizedBox(height: 15),
                CategoriesWidget(),
                const SizedBox(height: 15),
                const StoresSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}