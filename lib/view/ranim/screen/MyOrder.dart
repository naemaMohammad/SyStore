import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user_app/controller/ranim/myOrderController.dart';
import 'package:user_app/view/ranim/widgets/myOrder/card.dart';
import 'package:user_app/view/ranim/widgets/myOrder/orderFilter.dart';

class Myorder extends StatelessWidget {
  const Myorder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Order",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        elevation: 5,
        shadowColor: Colors.black,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            SizedBox(height: 10),
            OrderFilters(),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredOrders.length,
              itemBuilder: (context, index) {
                final order = controller.filteredOrders[index];
                return OrderCard(
                  orderId: order.id,
                  date: order.date,
                  total: order.total,
                  status: order.status,
                );
              },
            ),
          ],
        );
      }),
    );
  }
}