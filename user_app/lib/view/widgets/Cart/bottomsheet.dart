import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/cart/CartController.dart';
import 'package:user_app/core/routes/app_routes.dart';

void showOrderBottomSheet(BuildContext context, ViewCartController controller) {
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();

  final isValid = false.obs;

  void validate() {
    final phone = numberController.text.trim();
    final address = addressController.text.trim();

    isValid.value = phone.length == 10 && address.isNotEmpty;
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Order",
    barrierColor: Colors.black.withOpacity(0.2),
    transitionDuration: const Duration(milliseconds: 250),

    pageBuilder: (context, animation, secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),

            /// 🔥 Bottom Sheet
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),

                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Text(
                        "22".tr,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Number
                      _buildField(
                        context,
                        numberController,
                        "23".tr,
                        TextInputType.number,
                        1,
                        (_) => validate(),
                      ),

                      const SizedBox(height: 15),

                      /// Address
                      _buildField(
                        context,
                        addressController,
                        "24".tr,
                        TextInputType.text,
                        1,
                        (_) => validate(),
                      ),

                      const SizedBox(height: 15),

                      /// Notes
                      _buildField(
                        context,
                        notesController,
                        "25".tr,
                        TextInputType.text,
                        1,
                        (_) {},
                      ),

                      const SizedBox(height: 20),

                      /// Done Button
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isValid.value
                                ? () async {
                                    final phone = numberController.text.trim();
                                    final address = addressController.text
                                        .trim();

                                    final body = {
                                      "customer_phone": phone,
                                      "address": address,
                                      "address_details": notesController.text
                                          .trim(),
                                      "delivery_zone_id":
                                          controller.selectedZone?.id,
                                      "sub_total": controller.subTotal,
                                      "delivery_fee": controller.delivery,
                                      "total_price": controller.total,
                                    };

                                    await controller.createOrder(body);

                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.bottomSlide,
                                      title: '5'.tr,
                                      desc: '26'.tr,
                                      btnOkOnPress: () {
                                        Get.offNamedUntil(
                                          AppRoutes.home,
                                          (route) => false,
                                        );
                                      },
                                    ).show();
                                  }
                                : null,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),

                            child: Text("5".tr),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },

    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}

/// 🔥 reusable input field (بدون أي تغيير)
Widget _buildField(
  BuildContext context,
  TextEditingController controller,
  String hint, [
  TextInputType? keyboardType,
  int maxLines = 1,
  Function(String)? onChanged,
]) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    onChanged: onChanged,
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyMedium?.color,
      fontFamily: 'NunitoSans',
      fontFamilyFallback: ['Tajawal'],
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Theme.of(context).textTheme.bodySmall?.color,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: ['Tajawal'],
      ),
      filled: true,
      fillColor: Theme.of(context).secondaryHeaderColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
