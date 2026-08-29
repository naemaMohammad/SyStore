import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/home/main_layout_controller.dart';
import 'package:user_app/controller/order/viewOrderController.dart';
import 'package:user_app/view/widgets/viewOrder/card.dart';
import 'package:user_app/view/widgets/viewOrder/orderFilter.dart';

class Myorder extends StatelessWidget {
  const Myorder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    Future<void> _refreshOrders() async {
      await controller.fetchOrders();
    }

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
          onPressed: () => Get.find<MainLayoutController>().changeTab(0),
        ),
        title: Text(
          '10'.tr,
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
        onRefresh: _refreshOrders, 
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
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
                  physics: const AlwaysScrollableScrollPhysics(), 
                  itemCount: controller.filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = controller.filteredOrders[index];

                    return OrderCard(
                      orderId: order.id!,
                      date: (order.createdAt ?? "").split("T").first,
                      total: (double.tryParse(order.totalPrice ?? "0") ?? 0)
                          .toInt()
                          .toString(),
                      status: controller.getStatus(order.status),
                      rejectionReason: order.rejectionReason,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
