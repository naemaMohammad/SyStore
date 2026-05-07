

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/ranim/editOrderController.dart';
import 'package:user_app/view/ranim/widgets/editorder/editProductCard.dart';

class Editorder extends StatelessWidget {
  const Editorder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditOrderController>();

    return  Scaffold(
      backgroundColor: Colors.white,//Theme.of(context).scafolbacground
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
        padding: const EdgeInsets.only(bottom: 140),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final p = controller.products[index];
          return EditProductCard(
            image: p["image"]as String,
            title: p["title"]as String,
            price: p["price"]as int,
            size: p["size"]as String,
            color: p["color"]as String,
            qty: p["qty"]as int,

            onAdd: () => controller.increaseQty(index),
            onRemove: () => controller.decreaseQty(index),
            onDelete: () => controller.deleteItem(index),
          );
        },
      )),

    bottomNavigationBar: Obx(() => Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, -2),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [

      // Total
      _row("Total", "${controller.total} \$"),

      const SizedBox(height: 8),

      _row("Delivery", "2 \$"),

      const Divider(height: 20),
      
      _row(
        "Sub Total",
        "${controller.total + 2} \$",
        isBold: true,
      ),

      const SizedBox(height: 15),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // save logic
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text("Save Changes"),
        ),
      ),
    ],
  ),
)),
    );
  }

}Widget _row(String title, String value, {bool isBold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$title :",
        style: TextStyle(
          fontSize: 16,
          fontWeight:
              isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight:
              isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ],
  );
}