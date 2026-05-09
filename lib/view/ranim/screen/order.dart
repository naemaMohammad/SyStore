import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/ranim/editOrderController.dart';
import 'package:user_app/view/ranim/widgets/editorder/editProductCard.dart';
import 'package:user_app/view/ranim/widgets/order/bottomsheet.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditOrderController>();

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
          'My Cart',
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
          padding: const EdgeInsets.only(bottom: 140),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final p = controller.products[index];

            return EditProductCard(
              image: p["image"] as String,
              title: p["title"] as String,
              price: p["price"] as int,
              size: p["size"] as String,
              color: p["color"] as String,
              qty: p["qty"] as int,
              onAdd: () => controller.increaseQty(index),
              onRemove: () => controller.decreaseQty(index),
              onDelete: () => controller.deleteItem(index),
            );
          },
        ),
      ),

      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,

            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),

            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _row(context, "Total", "${controller.total} \$"),
              const SizedBox(height: 8),
              _row(context, "Delivery", "2 \$"),

              Divider(height: 20, color: Theme.of(context).dividerColor),

              _row(
                context,
                "Sub Total",
                "${controller.total + 2} \$",
                isBold: true,
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showOrderBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Send The Request"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String title,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title :",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
