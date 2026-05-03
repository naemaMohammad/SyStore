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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
        shadowColor: Colors.black,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
      ),

      body: Obx(() => ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return ProductCard(
            image: product["image"] as String,
            title: product["title"]as String,
            price: product["price"]as String,
            size: product["size"]as String,
            color: product["color"]as String,
            isSelected: index == 3, // بس للتجربة (نفس الصورة)
          );
        },
      )),
      bottomNavigationBar: const CartSummary(),
    );
  }
}