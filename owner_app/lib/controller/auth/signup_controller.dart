// lib/app/controllers/auth/signup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/view/screen/auth/create_store.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final socialMediaController = TextEditingController();

  var idImageFile = Rxn<File>();
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    socialMediaController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void setImage(File image) {
    idImageFile.value = image;
  }

  void _loadSavedData() {
    final fullName = box.read('temp_full_name');
    final email = box.read('temp_email');
    final phone = box.read('temp_phone');
    final socialMedia = box.read('temp_social_media');

    if (fullName != null) fullNameController.text = fullName;
    if (email != null) emailController.text = email;
    if (phone != null) phoneController.text = phone;
    if (socialMedia != null) socialMediaController.text = socialMedia;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      box.write('temp_full_name', fullNameController.text.trim());
      box.write('temp_email', emailController.text.trim());
      box.write('temp_phone', phoneController.text.trim());
      box.write('temp_password', passwordController.text);

      String socialMedia = socialMediaController.text.trim();
      if (socialMedia.isEmpty) {
        socialMedia = 'https://www.instagram.com';
      } else if (!socialMedia.startsWith('http://') &&
          !socialMedia.startsWith('https://')) {
        socialMedia = 'https://$socialMedia';
      }
      box.write('temp_social_media', socialMedia);

      if (idImageFile.value != null) {
        box.write('temp_id_image', idImageFile.value!.path);
      }

      Get.snackbar(
        'success'.tr,
        'Personal information saved! Please complete your store details.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.to(() => const CreateStore(), transition: Transition.fade);
    } catch (e) {
      print('❌ Registration Error: $e');
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.offNamed(AppRoutes.login);
  }
}
