import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 139, 145, 147),
          width: 0.2,
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.10),
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
                  "Order #$orderId",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text("order date $date"),
                Text("total $total \$"),
                Text("status $status"),
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
            child: const Icon(Icons.edit, size: 23),
          ),
          const SizedBox(width: 7),
          InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.question,
                animType: AnimType.bottomSlide,
                btnCancelOnPress: () {},
                descTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                desc: 'Are you sure you want to \n delete the order ?',
                btnOkOnPress: () {},
                btnOkText: "Delete",
                btnCancelColor: Colors.black,
                btnOkColor: const Color.fromARGB(255, 83, 82, 84),
                dismissOnTouchOutside: true,
                // ignore: deprecated_member_use
                barrierColor: Colors.black.withOpacity(0.8),
              ).show();
            },
            child: const Icon(Icons.delete, color: Colors.red, size: 24),
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
        child: const Icon(Icons.visibility, size: 20),
      );
    }
    if (status == "Cancelled") {
      return InkWell(
        onTap: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: 'Cancelled',
            desc: 'there are no captain',
            btnOkOnPress: () {},
            btnOkColor: const Color.fromARGB(255, 83, 82, 84),
            dismissOnTouchOutside: true,
            // ignore: deprecated_member_use
            barrierColor: Colors.black.withOpacity(0.8),
          ).show();
        },
        child: const Icon(Icons.info, color: Colors.red, size: 23),
      );
    }
    return const SizedBox();
  }
}
