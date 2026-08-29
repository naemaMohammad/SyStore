import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/favorite/favorite_controller.dart';
import 'package:user_app/controller/store/store_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/data/model/store_model.dart';
import 'package:user_app/view/screens/products/product_details.dart';


class ProductCard extends StatelessWidget {
  final ApiProductModel product;
    final StoreModel? store;
    final StoreController storeController = Get.find<StoreController>();
  ProductCard({super.key, required this.product, this.store});

  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool available = product.isAvailable;

    return GestureDetector(
     onTap: available
    ? () async {
        print('STORE PARAM IN PRODUCT CARD: ${store?.storeName}');
        print('PRODUCT STORE ID: ${product.storeId}');

        if (store != null) {
          Get.to(
            () => ProductDetailsPage(
              product: product,
              store: store,
            ),
          );
          return;
        }

        final storeId = product.storeId;

        if (storeId == null) {
          Get.snackbar(
            'Error',
            'Unable to identify store.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        await storeController.getStore(storeId);

        final loadedStore = storeController.store.value;

        if (loadedStore == null) {
          Get.snackbar(
            'Error',
            'Unable to load store.',
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        Get.to(
          () => ProductDetailsPage(
            product: product,
            store: loadedStore,
          ),
        );
      }
    : null,
      child: Opacity(
        opacity: available ? 1.0 : 0.55,
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.backgroundSecondaryDarkHome
                : AppColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.25)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: product.url.isEmpty
                          ? Container(
                              color: isDark
                                  ? Colors.grey[850]
                                  : Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.black26,
                                ),
                              ),
                            )
                          : ColorFiltered(
                              colorFilter: available
                                  ? const ColorFilter.mode(
                                      Colors.transparent,
                                      BlendMode.multiply,
                                    )
                                  : const ColorFilter.mode(
                                      Colors.grey,
                                      BlendMode.saturation,
                                    ),
                              child: Image.network(
                                product.url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: isDark
                                          ? Colors.grey[850]
                                          : Colors.grey.shade200,
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Colors.black26,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _buildFavoriteButton(),
                    ),
                    Positioned(top: 10, left: 10, child: _buildRatingBadge()),
                    if (!available)
                      Positioned.fill(
                        child: Center(child: _buildSoldOutBadge()),
                      ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontFamilyFallback: ['Cairo'],
                        color: isDark ? AppColors.textDarkHome : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.description ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textSecondaryDarkHome
                            : Colors.grey,
                        fontFamily: 'NunitoSans',
                        fontFamilyFallback: ['Tajawal'],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${product.priceValue.toStringAsFixed(2)} ${"currency".tr}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.secondary,
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Obx(() {
      final id = product.id;
      final isFav = id == null ? false : favoriteController.isFavorite(id);
      if (!product.isAvailable || id == null) {
        return _favoriteButtonVisual(isFav, enabled: false);
      }
      return GestureDetector(
        onTap: () {
          favoriteController.toggleFavorite(id, product: product);
        },
        child: _favoriteButtonVisual(isFav, enabled: true),
      );
    });
  }

  Widget _favoriteButtonVisual(bool isFav, {required bool enabled}) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? AppColors.primary : Colors.black,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSoldOutBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'sold_out'.tr,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
          fontFamilyFallback: ['Cairo'],
        ),
      ),
    );
  }

  Widget _buildRatingBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 3),
          Text(
            '${product.ratingValue}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'NunitoSans',
              fontFamilyFallback: ['Tajawal'],
            ),
          ),
        ],
      ),
    );
  }
}
