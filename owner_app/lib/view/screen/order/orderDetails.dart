import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/orders/orderDetailsController.dart';
import 'package:owner_app/view/widgets/orderDetails/cardproduct.dart';
import 'package:owner_app/view/widgets/orderDetails/cartsummary.dart';


class Orderdetails extends StatelessWidget {
  const Orderdetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Orderdetailscontroller>();

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
          onPressed: () => Get.back(),
        ),
        title: Text(
          "35".tr,
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final order = controller.order.value;
        if (order == null) {
          return Center(
            child: Text(
              'no_order_found'.tr,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          cacheExtent: 1000,
          itemCount: order.variants?.length ?? 0,
          itemBuilder: (context, index) {
            final product = order.variants![index];
            return ProductCard(
              image: product.product?.image ?? "",
              title: product.product?.name ?? "",
              price: product.pivot?.price ?? product.product?.price ?? "0",
              size: product.size?.name ?? "-",
              color: product.color?.name ?? "-",
              isSelected: false,
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value) return const SizedBox();
        final order = controller.order.value;
        if (order == null) return const SizedBox();
        return CartSummary(
          subtotal: order.subTotal ?? "0",
          deliveryFee: order.deliveryFee ?? "0",
          total: order.totalPrice ?? "0",
        );
      }),
    );
  }
}
