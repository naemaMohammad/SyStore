// lib/view/lana/auth/create_store.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/auth/create_store_controller.dart';
import 'package:owner_app/view/widgets/buttons/button.dart';
import 'package:owner_app/view/widgets/textFields/phone_field.dart';
import 'package:owner_app/view/widgets/textFields/text_field.dart';

class CreateStore extends StatelessWidget {
  const CreateStore({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CreateStoreController>()) {
      Get.put(CreateStoreController(), permanent: true);
    }
    final controller = Get.find<CreateStoreController>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'create_store'.tr,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                            fontFamilyFallback: const ['Cairo'],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // COVER + LOGO
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // COVER IMAGE
                            GestureDetector(
                              onTap: controller.pickCoverImage,
                              child: Obx(
                                () => Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).secondaryHeaderColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: controller.coverImageFile.value != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Image.file(
                                            controller.coverImageFile.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  "cover_store".tr,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'NunitoSans',
                                                    fontFamilyFallback: const [
                                                      'Tajawal',
                                                    ],
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.color,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall?.color,
                                                  size: 60,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            // LOGO IMAGE
                            Positioned(
                              bottom: -90,
                              child: GestureDetector(
                                onTap: controller.pickLogoImage,
                                child: Obx(
                                  () => Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).secondaryHeaderColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                    child:
                                        controller.logoImageFile.value != null
                                        ? ClipOval(
                                            child: Image.file(
                                              controller.logoImageFile.value!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                                size: 50,
                                                color: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.color,
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                "logo_store".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'NunitoSans',
                                                  fontFamilyFallback: const [
                                                    'Tajawal',
                                                  ],
                                                  color: Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall?.color,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 120),

                        // CATEGORY
                        GestureDetector(
                          onTap: controller.toggleCategory,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 22,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => Text(
                                      controller.selectedCategories.isEmpty
                                          ? "category".tr
                                          : controller.selectedCategories.join(
                                              ", ",
                                            ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'NunitoSans',
                                        fontFamilyFallback: const ['Tajawal'],
                                        color:
                                            controller
                                                .selectedCategories
                                                .isEmpty
                                            ? Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.color
                                            : Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.color,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => AnimatedRotation(
                                    turns: controller.isCategoryOpen.value
                                        ? 0.5
                                        : 0,
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: controller.isCategoryOpen.value
                                ? Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.categories.length,
                                      itemBuilder: (context, index) {
                                        final category =
                                            controller.categories[index];
                                        return Obx(() {
                                          return CheckboxListTile(
                                            value: controller.selectedCategories
                                                .contains(category),
                                            title: Text(
                                              category,
                                              style: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium?.color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'NunitoSans',
                                                fontFamilyFallback: const [
                                                  'Tajawal',
                                                ],
                                              ),
                                            ),
                                            activeColor: Theme.of(
                                              context,
                                            ).primaryColor,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical:
                                                      0, // ✅ بدون مسافة عمودية
                                                ),
                                            visualDensity: const VisualDensity(
                                              horizontal: 0,
                                              vertical:
                                                  -2, // ✅ تقليل المسافة بين العناصر
                                            ),
                                            onChanged: (_) {
                                              controller
                                                  .toggleCategorySelection(
                                                    category,
                                                  );
                                            },
                                          );
                                        });
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        const SizedBox(height: 30),

                        CustomTextField(
                          controller: controller.storeNameController,
                          hint: 'name_store'.tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter store name'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        PhoneTextField(
                          controller: controller.storePhoneController,
                          hintText: 'number_store'.tr,
                        ),
                        const SizedBox(height: 30),

                        CustomTextField(
                          controller: controller.locationController,
                          hint: 'location'.tr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter location'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        CustomTextField(
                          hint: "desc_store".tr,
                          controller: controller.descriptionController,
                          isDescription: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter store description'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: "continue".tr,
                                  onPressed: controller.createStore,
                                ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
