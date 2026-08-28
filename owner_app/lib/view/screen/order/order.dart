import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/orders/orderController.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/view/widgets/order/ordercard.dart';
class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Obx(() {
          return controller.isSearching.value
              ? TextField(
                  autofocus: true,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                  decoration: InputDecoration(
                    hintText: 'search_order_id'.tr,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontFamily: 'NunitoSans',
                      fontFamilyFallback: ['Tajawal'],
                      fontSize: 14,
                    ),
                  ),
                )
              : Text(
                  "10".tr,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontFamilyFallback: ['Cairo'],
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                );
        }),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                controller.isSearching.value = !controller.isSearching.value;
                if (!controller.isSearching.value) {
                  controller.searchQuery.value = "";
                }
              },
              icon: Icon(
                controller.isSearching.value ? Icons.close : Icons.search,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            );
          }),
        ],
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
        onRefresh: () async {
          // ✅ تحديث الطلبات عند السحب للأسفل
          await controller.fetchOrders();
        },
        color: AppColors.primary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            _filters(context),
            Expanded(
              child: SingleChildScrollView(
                physics:
                    const AlwaysScrollableScrollPhysics(), // ✅ مهم لتفعيل السحب
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (controller.filteredOrders.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text(
                          "36".tr,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 'NunitoSans',
                            fontFamilyFallback: ['Tajawal'],
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // ✅ مهم مع RefreshIndicator
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: controller.filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = controller.filteredOrders[index];
                      return OrderCard(order: order);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filters(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final filters = ["All", "Process", "Preparing", "On the way", "Delivered"];

    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: filters.map((e) {
            final isSelected = controller.selectedFilter.value == e;
            return GestureDetector(
              onTap: () => controller.changeFilter(e),
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : isDark
                      ? AppColors.backgroundSecondaryDarkHome
                      : AppColors.backgroundSecondaryLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : isDark
                        ? Colors.white12
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Text(
                  e.tr,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
