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
          'My Order',
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
      body: Column(
        children: [
          const SizedBox(height: 10),

          const OrderFilters(),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }

              return ListView.builder(
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
