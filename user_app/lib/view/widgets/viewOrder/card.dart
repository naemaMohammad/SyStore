import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order/viewOrderController.dart';
import 'package:user_app/view/widgets/viewOrder/dialogFunctionForDelete.dart';


class OrderCard extends StatelessWidget {
  final int orderId;
  final String date;
  final String total;
  final String status;
  final String? rejectionReason;
  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
    this.rejectionReason,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    IconData icon;
    Color color;

    switch (status) {
      case "Process":
        icon = Icons.refresh;
        color = const Color.fromARGB(255, 101, 131, 191);
        break;
      case "Preparing":
        icon = Icons.timelapse_outlined;
        color = Colors.orange;
        break;
      case "On the way":
        icon = Icons.local_shipping;
        color = Colors.amber;
        break;
      case "Delivered":
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case "Cancelled":
        icon = Icons.error_outline;
        color = Colors.red;
        break;
      default:
        icon = Icons.error;
        color = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.06),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 10, 3, 4),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 40),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'11'.tr} #$orderId",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  "${'12'.tr} $date",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),

                Text(
                  "${'2'.tr} $total ${'currency'.tr}",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),

                Text(
                  "${'13'.tr} $status",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NunitoSans',
                    fontFamilyFallback: ['Tajawal'],
                  ),
                ),
              ],
            ),
          ),

          buildInlineButtons(context),
        ],
      ),
    );
  }

  Widget buildInlineButtons(BuildContext context) {
    if (status == "Process") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed('/editorder', arguments: {"id": orderId});
            },
            child: Icon(
              Icons.edit,
              size: 23,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),

          const SizedBox(width: 7),

          InkWell(
            onTap: () {
              showAppDialog(
                context: context,
                title: '',
                message: '8'.tr,
                confirmText: '9'.tr,
                confirmColor: Theme.of(context).colorScheme.tertiary,
                icon: Icons.delete,
                onConfirm: () async {
                  final controller = Get.find<OrdersController>();
                  await controller.cancelOrder(orderId);
                },
              );
            },
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.tertiary,
              size: 24,
            ),
          ),
        ],
      );
    }

    if (status == "Preparing" ||
        status == "On the way" ||
        status == "Delivered") {
      return InkWell(
        onTap: () {
          Get.toNamed(
            '/showorder',
            arguments: {"id": orderId, "status": status},
          );
        },
        child: Icon(
          Icons.visibility,
          size: 20,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      );
    }

    if (status == "Cancelled" || status == "Rejected") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(
                '/showorder',
                arguments: {"id": orderId, "status": status},
              );
            },
            child: Icon(
              Icons.visibility,
              size: 20,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),

          const SizedBox(width: 10),

          /// 🔴 زر سبب الإلغاء / الرفض
          InkWell(
            onTap: () {
              // ✅ تعامل آمن مع rejectionReason
              String reasonText = '46'.tr; // "لا يوجد سبب"
              if (rejectionReason != null && rejectionReason!.isNotEmpty) {
                reasonText = rejectionReason!;
              }

              AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.bottomSlide,
                title: status == "Rejected" ? '44'.tr : '14'.tr,
                desc: status == "Rejected" ? reasonText : "34".tr,
                btnOkOnPress: () {},
                btnOkColor: Theme.of(context).colorScheme.primary,
                dismissOnTouchOutside: true,
                barrierColor: Colors.black.withOpacity(0.8),
                titleTextStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontFamilyFallback: ['Cairo'],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                descTextStyle: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontFamilyFallback: ['Tajawal'],
                  fontSize: 16,
                ),
              ).show();
            },
            child: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.tertiary,
              size: 23,
            ),
          ),
        ],
      );
    }

    return const SizedBox();
  }
}
