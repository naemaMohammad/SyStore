import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:user_app/controller/lilav/favorite_controller.dart';
import 'package:user_app/controller/lilav/main_layout_controller.dart';


class FavoritesPage extends StatelessWidget {
   final FavoriteController favoriteController = Get.put(FavoriteController());
   final FavoriteController controller =
    Get.put(FavoriteController());

  FavoritesPage({super.key});
 
  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية للمنتجات في المفضلة

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
onPressed: () {
  Get.find<MainLayoutController>().changeTab(0);
},
        ),
        title: Text(
          'favorite'.tr,
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
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // العنوان العلوي
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ), // مسافة علوية

            Obx(
              (){
              final favorites = controller.favoriteProducts;
                if (favoriteController.favoriteProducts.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('No favorites yet!'),
                    ),
                  );
                }
                return SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return favorites[index];
                }, childCount: favorites.length),
              );}
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ), // مسافة سفلية
          ],
        ),
      ),
    );
  }
}
