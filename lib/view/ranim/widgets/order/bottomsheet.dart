import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showOrderBottomSheet(BuildContext context) {
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();

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
                        "Order Information",
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
                        "Number",
                        TextInputType.number,
                      ),

                      const SizedBox(height: 15),

                      /// Address
                      _buildField(context, addressController, "Address"),

                      const SizedBox(height: 15),

                      /// Notes
                      _buildField(context, notesController, "Add your notes"),

                      const SizedBox(height: 20),

                      /// Done Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              title: 'Done!',
                              desc: 'Thank you for your order',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkColor: Theme.of(context).colorScheme.primary,
                              dismissOnTouchOutside: false,
                            ).show();
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),

                          child: const Text("Done"),
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

/// 🔥 reusable input field
Widget _buildField(
  BuildContext context,
  TextEditingController controller,
  String hint, [
  TextInputType? keyboardType,
  int maxLines = 1,
]) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
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
