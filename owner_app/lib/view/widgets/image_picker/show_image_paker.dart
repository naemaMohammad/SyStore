import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShowImagePicker {
  static void show({
    required BuildContext context,

    required Function(ImageSource source)
    onPick,
  }) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.transparent,

      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          decoration: BoxDecoration(
            color:
                Theme.of(context)
                    .scaffoldBackgroundColor,

            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              // TOP INDICATOR
              Container(
                width: 50,
                height: 10,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius:
                      BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              Text(
                "choose_image".tr,

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Raleway',
                  fontFamilyFallback: const [
                    'Cairo',
                  ],

                  color:
                      Theme.of(context).primaryColor,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "image_source".tr,

                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NunitoSans',
                  fontFamilyFallback: const [
                    'Tajawal',
                  ],

                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color,
                ),
              ),

              const SizedBox(height: 30),

              // OPTIONS
              Row(
                children: [
                  // CAMERA
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        onPick(ImageSource.camera);
                      },

                      child: Container(
                        height: 135,

                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).secondaryHeaderColor,

                          borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                        ),

                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 60,
                              height: 60,

                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context)
                                        .primaryColor,

                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons
                                    .camera_alt_outlined,

                                color: Colors.white,
                                size: 30,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "camera".tr,

                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.w600,

                                fontFamily:
                                    'Raleway',

                                fontFamilyFallback: const [
                                  'Cairo',
                                ],

                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // GALLERY
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        onPick(ImageSource.gallery);
                      },

                      child: Container(
                        height: 135,

                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).secondaryHeaderColor,

                          borderRadius:
                              BorderRadius.circular(
                                20,
                              ),
                        ),

                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 60,
                              height: 60,

                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context)
                                        .primaryColor,

                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons
                                    .photo_library_outlined,

                                color: Colors.white,
                                size: 30,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "gallery".tr,

                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.w600,

                                fontFamily:
                                    'Raleway',

                                fontFamilyFallback: const [
                                  'Cairo',
                                ],

                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}