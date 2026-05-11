import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/ranim/widgets/showMyorder/CartSummary.dart';
import 'package:user_app/view/ranim/widgets/showMyorder/productCard.dart';
import 'package:user_app/controller/ranim/ShowMyCartController.dart';

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
          '1'.tr,
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

      body: Obx(
        () => ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];

            return ProductCard(
              image: product["image"] as String,
              title: product["title"] as String,
              price: product["price"] as String,
              size: product["size"] as String,
              color: product["color"] as String,
              isSelected: index == 3,
            );
          },
        ),
      ),

      bottomNavigationBar: const CartSummary(),
    );
  }
}
