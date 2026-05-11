import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:user_app/view/ranim/widgets/myOrder/dialogFunctionForDelete.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String total;
  final String status;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            // ignore: deprecated_member_use
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 35),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${'11'.tr} #$orderId",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  "${'12'.tr} $date",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),

                Text(
                  "${'2'.tr} $total \$",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),

                Text(
                  "${'13'.tr} $status",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
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
              Get.toNamed('/editorder');
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
                onConfirm: () {
                  print('Item deleted');
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
          Get.toNamed('/showorder');
        },
        child: Icon(
          Icons.visibility,
          size: 20,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      );
    }

    if (status == "Cancelled") {
      return InkWell(
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: '14'.tr,
            desc: 'there are no captain',
            btnOkOnPress: () {},
            btnOkColor: Theme.of(context).colorScheme.primary,
            dismissOnTouchOutside: true,
            barrierColor: Colors.black.withOpacity(0.8),
          ).show();
        },
        child: Icon(
          Icons.info,
          color: Theme.of(context).colorScheme.tertiary,
          size: 23,
        ),
      );
    }

    return const SizedBox();
  }
}
