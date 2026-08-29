import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order/ShowOrderController.dart';
import 'package:user_app/data/utils/api_utils.dart';

import 'package:user_app/data/model/show_order_model.dart' as order_model;
import 'package:user_app/view/widgets/showOrder/CartSummary.dart';
import 'package:user_app/view/widgets/showOrder/ProductCard.dart';

class Showmycart extends StatelessWidget {
  const Showmycart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Showmycartcontroller>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

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
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          '35'.tr,
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
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order_model.Order? order = controller.order.value;

        if (order == null) {
          return const Center(child: Text("No order found"));
        }

        final variants = order.variants ?? [];

        return ListView.builder(
          itemCount: variants.length,
          itemBuilder: (context, index) {
            final product = variants[index];

            return ProductCard(
              productId: product.product?.id ?? 0,
              image: getFullImageUrl(product.product?.image),
              title: product.product?.name ?? "",
              price: product.pivot?.price ?? product.product?.price ?? "",
              size: product.size?.name ?? "",
              color: product.color?.name ?? "",
              showRateButton:
                  controller.normalizeStatus(order.status) == "Delivered",
              isRated: false,
            );
          },
        );
      }),

      bottomNavigationBar: const CartSummary(),
    );
  }
}
