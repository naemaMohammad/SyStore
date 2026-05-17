import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    required Color confirmColor,
    required IconData icon,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.grey.withOpacity(0.3),

      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,

          insetPadding:
              const EdgeInsets.symmetric(
            horizontal: 20,
          ),

          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,

            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 40),

                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  50,
                  20,
                  20,
                ),

                decoration: BoxDecoration(
                  color:
                      Theme.of(context).cardColor,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.3),

                      blurRadius: 20,

                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      "$title\n$message",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w700,

                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color,

                        fontFamily: 'Raleway',
                        fontFamilyFallback: [
                          'Cairo',
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                Get.back(),

                            child: Container(
                              height: 45,

                              decoration:
                                  BoxDecoration(
                                color: Theme.of(
                                        context)
                                    .secondaryHeaderColor,

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  12,
                                ),
                              ),

                              alignment:
                                  Alignment.center,

                              child: Text(
                                'cancel'.tr,

                                style: TextStyle(
                                  color: Theme.of(
                                          context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,

                                  fontSize: 15,

                                  fontWeight:
                                      FontWeight
                                          .w400,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();

                              onConfirm();
                            },

                            child: Container(
                              height: 45,

                              decoration:
                                  BoxDecoration(
                                color: confirmColor,

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  12,
                                ),
                              ),

                              alignment:
                                  Alignment.center,

                              child: Text(
                                confirmText,

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 15,

                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 0,

                child: Container(
                  padding:
                      const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).cardColor,

                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.3),

                        blurRadius: 10,
                      ),
                    ],
                  ),

                  child: Container(
                    padding:
                        const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: confirmColor,

                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}