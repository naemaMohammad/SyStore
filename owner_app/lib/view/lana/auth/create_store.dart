import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/view/lana/auth/verification.dart';
import 'package:owner_app/view/lana/widgets/buttons/button.dart';
import 'package:owner_app/view/lana/widgets/textFields/phone_field.dart';
import 'package:owner_app/view/lana/widgets/textFields/text_field.dart';
class CreateStore extends StatefulWidget {
  const CreateStore({super.key});
  @override
  State<CreateStore> createState() => _CreateStoreState();
}
class _CreateStoreState extends State<CreateStore> {
  File? coverImage;
  File? logoImage;
  final ImagePicker picker = ImagePicker();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storePhoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;
  List<String> selectedCategories = [];
  final List<String> categories = ["Women", "Men", "Girl", "Boy"];
  bool isCategoryOpen = false;
  Future<void> pickCoverImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        coverImage = File(image.path);
      });
    }
  }

  Future<void> pickLogoImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        logoImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          // WHITE CONTAINER
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      // TITLE
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
                            onTap: pickCoverImage,
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Theme.of(context).secondaryHeaderColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: coverImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        coverImage!,
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "cover_store".tr,
                                              style: TextStyle(
                                                fontSize: 16,
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
                          // LOGO IMAGE
                          Positioned(
                            bottom: -90,
                            child: GestureDetector(
                              onTap: pickLogoImage,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                                child: logoImage != null
                                    ? ClipOval(
                                        child: Image.file(
                                          logoImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_photo_alternate_outlined,
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
                        ],
                      ),
                      const SizedBox(height: 120),
                      // CATEGORY
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isCategoryOpen = !isCategoryOpen;
                          });
                        },
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
                                child: Text(
                                  selectedCategories.isEmpty
                                      ? "category".tr
                                      : selectedCategories.join(", "),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'NunitoSans',
                                    fontFamilyFallback: const ['Tajawal'],
                                    color: selectedCategories.isEmpty
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
                              AnimatedRotation(
                                turns: isCategoryOpen ? 0.5 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // CATEGORY LIST
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(top: 10),
                        // padding: isCategoryOpen
                        //   ? const EdgeInsets.all(10)
                        // : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: isCategoryOpen ? categories.length * 60 : 0,
                        child: isCategoryOpen
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  final isSelected = selectedCategories
                                      .contains(category);
                                  return CheckboxListTile(
                                    value: isSelected,
                                    title: Text(
                                      category,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'NunitoSans',
                                        fontFamilyFallback: const ['Tajawal'],
                                      ),
                                    ),
                                    activeColor: Theme.of(context).primaryColor,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    onChanged: (value) {
                                      setState(() {
                                        if (isSelected) {
                                          selectedCategories.remove(category);
                                        } else {
                                          selectedCategories.add(category);
                                        }
                                      });
                                    },
                                  );
                                },
                              )
                            : null,
                      ),
                      const SizedBox(height: 30),
                      // STORE NAME
                      CustomTextField(
                        controller: storeNameController,
                        hint: 'name_store'.tr,
                      ),
                      const SizedBox(height: 30),
                      // STORE PHONE
                      PhoneTextField(
                        controller: storePhoneController,
                        hintText: 'number_store'.tr,
                      ),
                      const SizedBox(height: 30),
                      // DESCRIPTION
                      CustomTextField(
                        hint: "desc_store".tr,
                        controller: descriptionController,
                        isDescription: true,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: "continue".tr,
                        onPressed: () {
                          /* showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const PendingDialog(),
                          );

                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.pop(context);*/

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CodeScreen(
                                title: 'hello_title',
                                subtitle: 'activation_code',
                                isSignUp: false,
                              ),
                            ),
                            // );
                            // }
                          );
                        },
                      ),
                      const SizedBox(height: 5),
                    ],
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
