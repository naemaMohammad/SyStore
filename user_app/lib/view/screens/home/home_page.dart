import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home/home_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/view/widgets/ads/AdsCarousel.dart';
import 'package:user_app/view/widgets/home_widgets/categories_widget.dart';
import 'package:user_app/view/widgets/home_widgets/top_product_section.dart';
import 'package:user_app/view/widgets/home_widgets/top_rated_stores_section.dart';
import 'package:user_app/view/widgets/search_bar/search_bar.dart';
import 'package:user_app/view/widgets/stores/stores_section.dart.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'home_title'.tr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: AppFonts.heading(),
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
                color: isDark ? AppColors.textDarkHome : AppColors.white,
              ),
        ),
        
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshHome,
        color: AppColors.primary,
        backgroundColor: isDark ? Colors.grey[800] : Colors.white,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(35),
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 8,
                right: 7,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const MySearchBar(),
                  const SizedBox(height: 15),
                  AdsCarousel(),
                  const SizedBox(height: 15),
                  const CategoriesWidget(),
                  const SizedBox(height: 15),
                  const StoresSection(),
                  const SizedBox(height: 15),
                  TopProductsSection(),
                  const SizedBox(height: 15),
                  TopRatedStoresSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}