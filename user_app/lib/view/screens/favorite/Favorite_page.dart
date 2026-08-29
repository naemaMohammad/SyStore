import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/favorite/favorite_controller.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/view/widgets/product/product_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteController controller = Get.find<FavoriteController>();

  @override
  void initState() {
    super.initState();
    controller.getFavorites();
  }

  Future<void> _refreshFavorites() async {
    await controller.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
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
                BoxShadow(
                  color: Theme.of(context).dividerColor.withOpacity(0.15),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshFavorites, 
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(), 
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              Obx(() {
                final favorites = controller.favorites;
                if (favorites.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text('No favorites yet!')),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.65,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ProductCard(product: favorites[index]);
                    }, childCount: favorites.length),
                  ),
                );
              }),

              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}
