import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/orders/orderController.dart';
import 'package:owner_app/core/theme/color.dart';
import 'package:owner_app/data/model/view_orders_model.dart';
import 'package:owner_app/view/widgets/order/rajaectDialog.dart';

class OrderCard extends StatelessWidget {
  final Orders order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return GestureDetector(
      onTap: () {
        Get.toNamed('/orderdetails', arguments: order.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.backgroundSecondaryDarkHome
              : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Expanded(
                  child: Text(
                    "#${order.id ?? ""}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontFamilyFallback: ['Cairo'],
                      color: textColor,
                    ),
                  ),
                ),
                // ACTIONS
                if ((order.status ?? "") == "process") ...[
                  GestureDetector(
                    onTap: () {
                      controller.acceptOrder(order);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "37".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      rejectDialog(context, controller, order);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.third,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "38".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 14),

            // INFO
            _info(
              context,
              Icons.person_outline,
              order.user?.fullName ?? "",
              isDark,
            ),
            _info(
              context,
              Icons.call_outlined,
              order.customerPhone ?? "",
              isDark,
            ),
            _info(
              context,
              Icons.location_on_outlined,
              order.address ?? "",
              isDark,
            ),
            _info(
              context,
              Icons.attach_money,
              "${order.totalPrice ?? '0'} SYP",
              isDark,
            ),
            const SizedBox(height: 18),

            // STATUS
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: (order.status == "rejected" || order.status == "reject")
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "39".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'NunitoSans',
                          fontFamilyFallback: ['Tajawal'],
                        ),
                      ),
                    )
                  : PopupMenuButton<String>(
                      onSelected: (value) {
                        controller.changeStatus(order, value);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "on_the_way",
                          child: Text(
                            "19".tr,
                            style: const TextStyle(
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: "delivered",
                          child: Text(
                            "20".tr,
                            style: const TextStyle(
                              fontFamily: 'NunitoSans',
                              fontFamilyFallback: ['Tajawal'],
                            ),
                          ),
                        ),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor(order.status, isDark),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _statusText(order.status),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NunitoSans',
                                fontFamilyFallback: ['Tajawal'],
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(BuildContext context, IconData icon, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isDark ? Colors.white54 : Colors.grey.shade600,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontFamilyFallback: ['Tajawal'],
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusText(String? status) {
    switch (status) {
      case "process":
        return "Process";
      case "preparing":
        return "Preparing";
      case "on_the_way":
        return "On the way";
      case "delivered":
        return "Delivered";
      default:
        return "Reject";
    }
  }

  Color _statusColor(String? status, bool isDark) {
    switch (status) {
      case "process":
        return AppColors.primary;
      case "preparing":
        return const Color(0xFFF9A825);
      case "on_the_way":
        return const Color(0xFF42A5F5);
      case "delivered":
        return AppColors.secondary;
      default:
        return isDark ? Colors.grey.shade700 : Colors.grey.shade500;
    }
  }
}
