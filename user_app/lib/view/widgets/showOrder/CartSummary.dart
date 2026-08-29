import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:user_app/controller/order/ShowOrderController.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Showmycartcontroller>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,

          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],

          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                controller.order.value?.deliveryZone?.regionsAr ?? "",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NunitoSans',
                  fontFamilyFallback: ['Tajawal'],
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 10),

            _row(
              context,
              "2".tr,
              "${controller.order.value?.subTotal ?? '0'} ${'currency'.tr}",
            ),
            const SizedBox(height: 8),

            _row(
              context,
              "3".tr,
              "${controller.order.value?.deliveryFee ?? '0'} ${'currency'.tr}",
            ),

            Divider(height: 20, color: Theme.of(context).dividerColor),

            _row(
              context,
              "4".tr,
              "${controller.order.value?.totalPrice ?? '0'} ${'currency'.tr}",
              isBold: true,
            ),
          ],
        ),
      );
    });
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
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Tajawal'],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'NunitoSans',
            fontFamilyFallback: ['Tajawal'],
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}
