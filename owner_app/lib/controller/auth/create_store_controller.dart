import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:owner_app/view/screen/delivery/delivery_price.dart';

class CreateStoreController extends GetxController {
  static const List<String> registrationTempKeys = [
    'temp_full_name',
    'temp_email',
    'temp_phone',
    'temp_password',
    'temp_social_media',
    'temp_id_image',
    'temp_store_name',
    'temp_store_phone',
    'temp_location',
    'temp_description',
    'temp_category_ids',
    'temp_logo_image',
    'temp_cover_image',
  ];

  final formKey = GlobalKey<FormState>();
  final storeNameController = TextEditingController();
  final storePhoneController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  var coverImageFile = Rxn<File>();
  var logoImageFile = Rxn<File>();
  var selectedCategories = <String>[].obs;
  var isCategoryOpen = false.obs;
  final List<String> categories = ["men", "women", "boys", "girls"];
  var isLoading = false.obs;
  final box = GetStorage();
  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  @override
  void onClose() {
    storeNameController.dispose();
    storePhoneController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void toggleCategory() {
    isCategoryOpen.toggle();
  }

  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  Future<void> pickCoverImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // ✅ ضغط الصورة
    );
    if (image != null) {
      coverImageFile.value = File(image.path);
    }
  }

  Future<void> pickLogoImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // ✅ ضغط الصورة
    );
    if (image != null) {
      logoImageFile.value = File(image.path);
    }
  }

  void _loadSavedData() {
    final storeName = box.read('temp_store_name');
    final storePhone = box.read('temp_store_phone');
    final location = box.read('temp_location');
    final description = box.read('temp_description');
    final storedCategoryIds = box.read('temp_category_ids');
    final logoImagePath = box.read('temp_logo_image');
    final coverImagePath = box.read('temp_cover_image');

    if (storeName != null) storeNameController.text = storeName;
    if (storePhone != null) storePhoneController.text = storePhone;
    if (location != null) locationController.text = location;
    if (description != null) descriptionController.text = description;
    if (storedCategoryIds is List) {
      final categoryById = {
        1: "men",
        2: "women",
        3: "boys",
        4: "girls",
      };
      selectedCategories.assignAll(
        storedCategoryIds
            .map((id) => categoryById[int.tryParse(id.toString())])
            .whereType<String>(),
      );
    }
    if (logoImagePath != null && logoImagePath.toString().isNotEmpty) {
      logoImageFile.value = File(logoImagePath);
    }
    if (coverImagePath != null && coverImagePath.toString().isNotEmpty) {
      coverImageFile.value = File(coverImagePath);
    }
  }

  void resetFormState({bool clearPersisted = false}) {
    storeNameController.clear();
    storePhoneController.clear();
    locationController.clear();
    descriptionController.clear();
    coverImageFile.value = null;
    logoImageFile.value = null;
    selectedCategories.clear();
    isCategoryOpen.value = false;
    isLoading.value = false;
    if (clearPersisted) {
      clearRegistrationTempData();
    }
  }

  static void clearRegistrationTempData() {
    final storage = GetStorage();
    for (final key in registrationTempKeys) {
      storage.remove(key);
    }
  }

  static void resetExistingRegistrationControllers() {
    clearRegistrationTempData();
    if (Get.isRegistered<CreateStoreController>()) {
      Get.find<CreateStoreController>().resetFormState();
    }
  }

  Future<void> createStore() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedCategories.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please select at least one category'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      box.write('temp_store_name', storeNameController.text.trim());
      box.write('temp_store_phone', storePhoneController.text.trim());
      box.write('temp_location', locationController.text.trim());
      box.write('temp_description', descriptionController.text.trim());
      final categoryMap = {
        "men": 1,
        "women": 2,
        "boys": 3,
        "girls": 4,
      };
      final categoryIds =
          selectedCategories.map((c) => categoryMap[c] ?? 0).toList();
      box.write('temp_category_ids', categoryIds);
      if (logoImageFile.value != null) {
        box.write('temp_logo_image', logoImageFile.value!.path);
      }
      if (coverImageFile.value != null) {
        box.write('temp_cover_image', coverImageFile.value!.path);
      }
      Get.snackbar(
        'success'.tr,
        'Store details saved! Please set delivery prices.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.to(
        () => const DeliveryPricesScreen(),
        transition: Transition.fade,
      );
    } catch (e) {
      print('❌ Create Store Error: $e');
      Get.snackbar(
        'error'.tr,
        'An error occurred. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
