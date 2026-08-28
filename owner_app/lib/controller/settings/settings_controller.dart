// lib/app/controllers/settings_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/model/merchant_auth_response.dart';
import 'package:owner_app/data/services/api_service.dart';

class SettingsController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final socialMediaController = TextEditingController();

  String? oldName;
  String? oldPhone;
  String? oldSocialMedia;

  var isUpdating = false.obs;
  var isLoggingOut = false.obs;
  var isDeleting = false.obs;
  String? _lastUpdateError;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final storedUserData = box.read('user_data');
    if (storedUserData is Map) {
      final userData = Map<String, dynamic>.from(storedUserData);
      nameController.text =
          _firstString(userData, ['full_name', 'fullName', 'store_name']) ?? '';
      phoneController.text =
          _firstString(userData, ['phone', 'store_phone']) ?? '';
      socialMediaController.text =
          _firstString(userData, ['social_media', 'socialMedia']) ?? '';

      oldName = nameController.text;
      oldPhone = phoneController.text;
      oldSocialMedia = socialMediaController.text;

      print(
        '✅ Loaded user data: name=$oldName, phone=$oldPhone, social=$oldSocialMedia',
      );
    } else {
      // إذا لم توجد بيانات، حاول جلبها من الـ API
      _fetchUserDataFromApi();
    }
  }

  // ✅ دالة جديدة لجلب البيانات من الـ API
  Future<void> _fetchUserDataFromApi() async {
    try {
      final token = box.read('token');
      if (token == null) return;

      final response = await ApiService.merchantApi.getStore();
      final storeData = _extractStoreData(response);

      if (storeData != null) {
        final userData = box.read('user_data') as Map<String, dynamic>? ?? {};
        userData['full_name'] =
            _firstString(storeData, ['full_name', 'fullName', 'store_name']) ??
                '';
        userData['phone'] =
            _firstString(storeData, ['phone', 'store_phone']) ?? '';
        userData['social_media'] =
            _firstString(storeData, ['social_media', 'socialMedia']) ?? '';
        userData['store_name'] =
            _firstString(storeData, ['store_name', 'full_name', 'fullName']) ??
                '';
        userData['store_phone'] =
            _firstString(storeData, ['store_phone', 'phone']) ?? '';
        userData['location'] = storeData['location'] ?? '';
        userData['description'] = storeData['description'] ?? '';
        box.write('user_data', userData);

        // تحديث الـ Controllers
        nameController.text = userData['full_name'] ?? '';
        phoneController.text = userData['phone'] ?? '';
        socialMediaController.text = userData['social_media'] ?? '';

        oldName = nameController.text;
        oldPhone = phoneController.text;
        oldSocialMedia = socialMediaController.text;

        print(
          '✅ Fetched user data from API: name=$oldName, phone=$oldPhone, social=$oldSocialMedia',
        );
      }
    } catch (e) {
      print('❌ Fetch User Data Error: $e');
    }
  }

  // ✅ دالة مساعدة لاستخراج بيانات المتجر
  Map<String, dynamic>? _extractStoreData(dynamic response) {
    if (response is! Map) return null;

    final store = response['store'];
    if (store is Map) return Map<String, dynamic>.from(store);

    final data = response['data'];
    if (data is Map) {
      final nestedStore = data['store'];
      if (nestedStore is Map) return Map<String, dynamic>.from(nestedStore);
      return Map<String, dynamic>.from(data);
    }

    return null;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    socialMediaController.dispose();
    super.onClose();
  }

  // ✅ دالة موحدة لتحديث جميع البيانات
  Future<bool> _updateMerchantData({
    required String name,
    required String phone,
    required String socialMedia,
  }) async {
    try {
      _lastUpdateError = null;
      final response = await ApiService.merchantApi.updateMerchant(
        name,
        phone,
        socialMedia,
      );

      if (_isSuccess(response)) {
        // تحديث القيم القديمة
        oldName = name;
        oldPhone = phone;
        oldSocialMedia = socialMedia;

        // حفظ في التخزين
        _saveToStorage(response);
        print(
          '✅ Merchant data updated: name=$name, phone=$phone, social=$socialMedia',
        );
        return true;
      }
      return false;
    } catch (e) {
      print('❌ Update Merchant Error: $e');
      _lastUpdateError = ApiService.errorMessage(e);
      return false;
    }
  }

  void saveName() async {
    final newName = nameController.text.trim();
    if (newName.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your name'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      nameController.text = oldName ?? '';
      return;
    }

    try {
      isUpdating.value = true;

      final success = await _updateMerchantData(
        name: newName,
        phone: phoneController.text.trim(),
        socialMedia: socialMediaController.text.trim(),
      );

      if (success) {
        Get.snackbar(
          'success'.tr,
          'Name updated successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        nameController.text = oldName ?? '';
        Get.snackbar(
          'error'.tr,
          _lastUpdateError ?? 'Failed to update name.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      nameController.text = oldName ?? '';
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  void savePhone() async {
    final newPhone = phoneController.text.trim();
    if (newPhone.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your phone number'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      phoneController.text = oldPhone ?? '';
      return;
    }

    try {
      isUpdating.value = true;

      final success = await _updateMerchantData(
        name: nameController.text.trim(),
        phone: newPhone,
        socialMedia: socialMediaController.text.trim(),
      );

      if (success) {
        Get.snackbar(
          'success'.tr,
          'Phone updated successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        phoneController.text = oldPhone ?? '';
        Get.snackbar(
          'error'.tr,
          _lastUpdateError ?? 'Failed to update phone.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      phoneController.text = oldPhone ?? '';
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  void saveSocialMedia() async {
    try {
      isUpdating.value = true;

      final success = await _updateMerchantData(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        socialMedia: socialMediaController.text.trim(),
      );

      if (success) {
        Get.snackbar(
          'success'.tr,
          'Social media updated successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        socialMediaController.text = oldSocialMedia ?? '';
        Get.snackbar(
          'error'.tr,
          _lastUpdateError ?? 'Failed to update social media.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      socialMediaController.text = oldSocialMedia ?? '';
      Get.snackbar(
        'error'.tr,
        ApiService.errorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

void _saveToStorage([MerchantAuthResponse? response]) {
  // جلب البيانات القديمة من التخزين
  final storedUserData = box.read('user_data');
  final userData = storedUserData is Map
      ? Map<String, dynamic>.from(storedUserData)
      : <String, dynamic>{};

  // إذا في استجابة من الـ API، ندمجها
  final responseUser = _extractUserData(response);
  if (responseUser != null) {
    userData.addAll(responseUser);
  }

  // ✅ تحديث البيانات من الـ Controllers (دمج وليس استبدال)
  final name = nameController.text.trim();
  final phone = phoneController.text.trim();
  final socialMedia = socialMediaController.text.trim();

  // ✅ نحدث فقط الحقول المتغيرة، ونبقي الباقي كما هو
  if (name.isNotEmpty) {
    userData['full_name'] = name;
    userData['fullName'] = name;
    userData['store_name'] = name;
  }

  if (phone.isNotEmpty) {
    userData['phone'] = phone;
    userData['store_phone'] = phone;
  }

  if (socialMedia.isNotEmpty) {
    userData['social_media'] = socialMedia;
    userData['socialMedia'] = socialMedia;
  }

  // ✅ حفظ البيانات المدمجة
  box.write('user_data', userData);
  print('✅ User data saved to storage: $userData');
}

Future<void> updateProfile() async {
  final name = nameController.text.trim();
  final phone = phoneController.text.trim();
  final socialMedia = socialMediaController.text.trim();

  if (!validateFields()) {
    _restoreOldValues();
    return;
  }

  try {
    isUpdating.value = true;

    final success = await _updateMerchantData(
      name: name,
      phone: phone,
      socialMedia: socialMedia,
    );

    if (success) {
      // ✅ تحديث القيم القديمة بعد النجاح
      oldName = name;
      oldPhone = phone;
      oldSocialMedia = socialMedia;

      // ✅ تحديث التخزين المحلي (دمج البيانات)
      _saveToStorage();

      Get.snackbar(
        'success'.tr,
        'Profile updated successfully!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _restoreOldValues();
      Get.snackbar(
        'error'.tr,
        'Failed to update profile.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    print('Update Profile Error: $e');
    _restoreOldValues();
    Get.snackbar(
      'error'.tr,
      ApiService.errorMessage(e),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isUpdating.value = false;
  }
}

  bool validateFields() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your name'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please enter your phone number'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  void _restoreOldValues() {
    nameController.text = oldName ?? '';
    phoneController.text = oldPhone ?? '';
    socialMediaController.text = oldSocialMedia ?? '';
  }

  Future<void> logout() async {
    try {
      isLoggingOut.value = true;

      await ApiService.merchantApi.logout();

      Get.snackbar(
        'success'.tr,
        'Logged out successfully!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Logout Error: $e');
    } finally {
      _clearSession();
      isLoggingOut.value = false;
      Get.offAllNamed(AppRoutes.start);
    }
  }

  Future<void> deleteAccount() async {
    try {
      isDeleting.value = true;

      await ApiService.merchantApi.deleteAccount();

      Get.snackbar(
        'success'.tr,
        'Account deleted successfully!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Delete Account Error: $e');
    } finally {
      _clearSession();
      isDeleting.value = false;
      Get.offAllNamed(AppRoutes.start);
    }
  }

  void goToDeliveryPrices() {
    Get.toNamed(AppRoutes.deliveryPrices);
  }

  Map<String, dynamic>? _extractUserData(MerchantAuthResponse? response) {
    if (response == null) return null;

    if (response.userData != null) {
      return response.userData!.toJson();
    }
    if (response.merchant != null) {
      return Map<String, dynamic>.from(response.merchant!);
    }
    if (response.store != null) {
      return Map<String, dynamic>.from(response.store!);
    }

    return null;
  }

  String? _firstString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }

  bool _isSuccess(MerchantAuthResponse response) {
    final message = response.message?.toLowerCase() ?? '';
    return response.success ||
        message.contains('success') ||
        message.contains('updated') ||
        message.contains('تم');
  }

  void _clearSession() {
    box.remove('token');
    box.remove('user_data');
    box.remove('reset_email');
    box.remove('reset_otp');
    box.remove('register_email');
  }
}
