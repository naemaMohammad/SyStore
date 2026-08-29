import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_app/core/routes/app_routes.dart';
import 'package:user_app/data/services/api_client.dart';
import 'package:user_app/data/services/token_service.dart';
import 'package:user_app/data/utils/api_utils.dart';

class SettingsController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var isLoggingOut = false.obs;
  final box = GetStorage();
  ApiClient get api => Get.find<ApiClient>();
  TokenService get tokens => Get.find<TokenService>();
  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    Map<String, dynamic>? userData = box.read('user_data');
    if (userData != null) {
      nameController.text = userData['full_name'] ?? '';
      phoneController.text = userData['phone'] ?? '';
    } else {
      nameController.text = '';
      phoneController.text = '';
    }
  }

  void loadUserData(Map<String, dynamic> userData) {
    nameController.text = userData['full_name'] ?? '';
    phoneController.text = userData['phone'] ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your name'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (phone.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your phone number'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      Get.snackbar(
        'error'.tr,
        'Phone must contain numbers only'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (phone.length != 10) {
      Get.snackbar(
        'error'.tr,
        'Phone number must be 10 digits'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      isUpdating.value = true;
      final response = await api.updateProfile(
        nameController.text.trim(),
        phoneController.text.trim(),
      );
      bool isSuccess =
          response.success == true ||
          response.message?.toLowerCase().contains('success') == true ||
          response.message?.toLowerCase().contains('updated') == true;

      if (isSuccess) {
        Map<String, dynamic>? userData = box.read('user_data');
        if (userData != null) {
          userData['full_name'] = nameController.text.trim();
          userData['phone'] = phoneController.text.trim();
          box.write('user_data', userData);
        }

        Get.snackbar(
          'success'.tr,
          'Profile updated successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'error'.tr,
          response.message ?? 'Failed to update profile.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        apiErrorMessage(e, 'An error occurred. Please try again.'),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoggingOut.value = true;
      await tokens.clearToken();
      box.remove('token');
      box.remove('user_data');

      Get.snackbar(
        'success'.tr,
        'Logged out successfully!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAllNamed(AppRoutes.start);
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'An error occurred. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoggingOut.value = false;
    }
  }

  Future<void> openFormLink() async {
    try {
      isLoading.value = true;

      final response = await api.getFormLink();
      final link = response is Map<String, dynamic>
          ? response['form_link'] as String?
          : null;

      if (link == null || link.isEmpty) {
        Get.snackbar(
          'error'.tr,
          'Form link not found.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final uri = Uri.parse(link);
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened) {
        Get.snackbar(
          'error'.tr,
          'Could not open the form link.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Open Form Error: $e');
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
