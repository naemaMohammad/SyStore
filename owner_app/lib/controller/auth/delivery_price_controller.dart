import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:owner_app/controller/auth/create_store_controller.dart';
import 'package:owner_app/core/routes/app_routes.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'dart:io';

import 'package:owner_app/view/screen/auth/verification.dart';

class DeliveryPriceController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  final areas = <Map<String, dynamic>>[].obs;
  final List<TextEditingController> priceControllers = [];

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true; // ✅ نبدأ بتحميل
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      await loadDeliveryZones(showLoading: false);

      final token = box.read('token');
      if (token != null && token.toString().isNotEmpty) {
        await loadDeliveryPrices(showLoading: false);
      }
    } finally {
      isLoading.value = false; // ✅ نوقف التحميل بعد ما نخلص
    }
  }

  Future<void> loadDeliveryZones({bool showLoading = true}) async {
    try {
      if (showLoading) isLoading.value = true;
      print('📤 Fetching delivery zones from API...');

      final response = await ApiService.merchantApi.getDeliveryZones();

      print('📥 Raw Response: $response');

      final zones = _extractList(response, keys: ['data', 'delivery_zones']);

      print('✅ Zones count: ${zones.length}');

      areas.clear();
      for (var zone in zones) {
        if (zone is! Map) continue;

        final regions = Get.locale?.languageCode == 'ar'
            ? zone['regions_ar'] ?? ''
            : zone['regions_en'] ?? '';

        areas.add({
          'id': zone['id'],
          'title': regions,
          'sector_name_ar': zone['sector_name_ar'] ?? '',
          'sector_name_en': zone['sector_name_en'] ?? '',
          'regions_ar': zone['regions_ar'] ?? '',
          'regions_en': zone['regions_en'] ?? '',
          'enabled': false,
          'price': '',
        });
      }

      for (var controller in priceControllers) {
        controller.dispose();
      }
      priceControllers.clear();
      for (int i = 0; i < areas.length; i++) {
        priceControllers.add(TextEditingController());
      }

      areas.refresh();
      print('✅ Loaded ${areas.length} delivery zones');
    } catch (e) {
      print('❌ Load Delivery Zones Error: $e');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> loadDeliveryPrices({bool showLoading = true}) async {
    try {
      if (showLoading) isLoading.value = true;

      if (areas.isEmpty) {
        await loadDeliveryZones(showLoading: false);
      }

      final response = await ApiService.merchantApi.getStore();

      final storeData = _extractStoreData(response);
      final deliveryZones = _extractList(
        storeData,
        keys: ['delivery_zones', 'deliveryZones'],
      );

      print('✅ Store delivery prices count: ${deliveryZones.length}');
      final Map<int, dynamic> pricedZones = {};
      for (final item in deliveryZones) {
        if (item is Map) {
          final zoneId = _zoneIdFromStoreZone(item);
          if (zoneId != null) {
            pricedZones[zoneId] = item;
          }
        }
      }

      for (int i = 0; i < areas.length; i++) {
        final zoneId = areas[i]['id'];

        if (pricedZones.containsKey(zoneId)) {
          final zone = pricedZones[zoneId];
          final price = _priceFromStoreZone(zone);
          final priceText = price == null ? '' : price.toString();
          areas[i]['price'] = priceText;
          areas[i]['enabled'] = true;
          if (i < priceControllers.length) {
            priceControllers[i].text = priceText;
          }
          print('✅ Zone ${areas[i]['id']} loaded: price = $priceText, enabled = true');
        } else {
          areas[i]['price'] = '';
          areas[i]['enabled'] = false;
          if (i < priceControllers.length) {
            priceControllers[i].clear();
          }
          print('❌ Zone ${areas[i]['id']} is not active (no price)');
        }
      }

      areas.refresh();
    } catch (e) {
      print('❌ Load Delivery Prices Error: $e');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  void toggleArea(int index, bool value) {
    if (value == true) {
      if (index < priceControllers.length) {
        areas[index]['price'] = priceControllers[index].text.trim();
      }
      final price = areas[index]['price'].toString().trim();
      if (_parsePrice(price) == null) {
        Get.snackbar(
          'warning'.tr,
          'invalid_price'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }
    } else {
      areas[index]['price'] = '';
      if (index < priceControllers.length) {
        priceControllers[index].clear();
      }
    }
    areas[index]["enabled"] = value;
    areas.refresh();
  }

  void updatePrice(int index, String price) {
    areas[index]['price'] = price;
    if (priceControllers.length > index &&
        priceControllers[index].text != price) {
      priceControllers[index].text = price;
    }
  }

  void saveAllPrices() {
    for (int i = 0; i < areas.length; i++) {
      _syncPriceFromController(i);
    }
    areas.refresh();
  }

  String? validatePrices() {
    final activeAreas = areas.where((area) => area['enabled'] == true).toList();

    if (activeAreas.isEmpty) {
      return 'Please enable at least one delivery zone'.tr;
    }

    for (var area in activeAreas) {
      final priceStr = area['price'].toString().trim();
      if (priceStr.isEmpty) {
        return 'Please set a price for all enabled areas'.tr;
      }
      if (_parsePrice(priceStr) == null) {
        return 'Please set a valid price for all enabled areas'.tr;
      }
    }

    return null;
  }

  Future<void> confirmPrices() async {
    saveAllPrices();

    final validationError = validatePrices();
    if (validationError != null) {
      Get.snackbar(
        'error'.tr,
        validationError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final fullName = box.read('temp_full_name') ?? '';
      final email = box.read('temp_email') ?? '';
      final phone = box.read('temp_phone') ?? '';
      final password = box.read('temp_password') ?? '';
      final socialMedia =
          box.read('temp_social_media') ?? 'https://www.instagram.com';
      final storeName = box.read('temp_store_name') ?? '';
      final storePhone = box.read('temp_store_phone') ?? '';
      final location = box.read('temp_location') ?? '';
      final description = box.read('temp_description') ?? '';
      final storedCategoryIds = box.read('temp_category_ids');
      final categoryIds = storedCategoryIds is List
          ? storedCategoryIds
              .map((id) => int.tryParse(id.toString()) ?? 0)
              .where((id) => id > 0)
              .toList()
          : <int>[];
      File? idImage;
      File? logoImage;
      File? coverImage;
      final idImagePath = box.read('temp_id_image');
      final logoImagePath = box.read('temp_logo_image');
      final coverImagePath = box.read('temp_cover_image');
      
      if (idImagePath != null && idImagePath.toString().isNotEmpty) {
        final file = File(idImagePath);
        if (await file.exists()) {
          idImage = file;
        }
      }
      if (logoImagePath != null && logoImagePath.toString().isNotEmpty) {
        final file = File(logoImagePath);
        if (await file.exists()) {
          logoImage = file;
        }
      }
      if (coverImagePath != null && coverImagePath.toString().isNotEmpty) {
        final file = File(coverImagePath);
        if (await file.exists()) {
          coverImage = file;
        }
      }
      
      final deliveryZones = areas
          .where((area) =>
              area['enabled'] == true &&
              _parsePrice(area['price']) != null)
          .map((area) {
        return {
          'delivery_zone_id': area['id'],
          'price': _formatPriceForRequest(area['price']),
        };
      }).toList();
      
      if (deliveryZones.isEmpty) {
        Get.snackbar(
          'warning'.tr,
          'Please enable at least one delivery zone'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }
      
      print('📤 Sending ${deliveryZones.length} active zones');
      for (var zone in deliveryZones) {
        print('   • Zone ${zone['delivery_zone_id']} -> ${zone['price']} SYP');
      }
      
      final fcmToken = box.read('fcm_token') ?? '';
      final formData = dio.FormData();
      formData.fields.addAll([
        MapEntry('full_name', fullName),
        MapEntry('phone', phone),
        MapEntry('email', email),
        MapEntry('password', password),
        MapEntry('social_media', socialMedia),
        MapEntry('store_name', storeName),
        MapEntry('store_phone', storePhone),
        MapEntry('location', location),
        MapEntry('description', description),
        MapEntry('fcm_token', fcmToken),
      ]);
      
      for (int i = 0; i < categoryIds.length; i++) {
        formData.fields.add(
          MapEntry('category_ids[$i]', categoryIds[i].toString()),
        );
      }
      
      for (int i = 0; i < deliveryZones.length; i++) {
        final zone = deliveryZones[i];
        formData.fields.add(
          MapEntry(
            'delivery_zones[$i][delivery_zone_id]',
            zone['delivery_zone_id'].toString(),
          ),
        );
        formData.fields.add(
          MapEntry('delivery_zones[$i][price]', zone['price'].toString()),
        );
      }
      
      if (idImage != null && await idImage.exists()) {
        formData.files.add(
          MapEntry('id_image', await dio.MultipartFile.fromFile(idImage.path)),
        );
      }
      if (logoImage != null && await logoImage.exists()) {
        formData.files.add(
          MapEntry(
            'logo_image',
            await dio.MultipartFile.fromFile(logoImage.path),
          ),
        );
      }
      if (coverImage != null && await coverImage.exists()) {
        formData.files.add(
          MapEntry(
            'cover_image',
            await dio.MultipartFile.fromFile(coverImage.path),
          ),
        );
      }
      
      final response = await ApiService.dio.post(
        '/merchant/register',
        data: formData,
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final token = data['token'];
        final user = _extractUserData(data);
        if (token != null) box.write('token', token);
        if (user != null) {
          final userData = Map<String, dynamic>.from(user);
          userData['full_name'] = fullName.isNotEmpty ? fullName : userData['full_name'] ?? '';
          userData['phone'] = phone.isNotEmpty ? phone : userData['phone'] ?? '';
          userData['store_name'] = storeName.isNotEmpty ? storeName : userData['store_name'] ?? '';
          userData['social_media'] = socialMedia.isNotEmpty ? socialMedia : userData['social_media'] ?? '';
          userData['store_phone'] = storePhone.isNotEmpty ? storePhone : userData['store_phone'] ?? '';
          userData['location'] = location.isNotEmpty ? location : userData['location'] ?? '';
          userData['description'] = description.isNotEmpty ? description : userData['description'] ?? '';
          box.write('user_data', userData);
          print('✅ User data saved on registration: $userData');
        }
        box.write('register_email', email);
        _clearTempData();
        CreateStoreController.resetExistingRegistrationControllers();
        Get.snackbar(
          'success'.tr,
          'Account created successfully! Please verify your email.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(
          () => CodeScreen(
            title: 'hello_title',
            subtitle: 'activation_code',
            isSignUp: true,
          ),
          arguments: {'email': email, 'isSignUp': true},
          transition: Transition.fade,
        );
      } else {
        final data = response.data as Map<String, dynamic>;
        Get.snackbar(
          'error'.tr,
          data['message'] ?? 'Registration failed'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Registration Error: $e');
      if (e is dio.DioException) {
        print('📌 Response Data: ${e.response?.data}');
        print('📌 Status Code: ${e.response?.statusCode}');
      }
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

  Future<void> updatePrices() async {
    saveAllPrices();
    final validationError = validatePrices();
    if (validationError != null) {
      Get.snackbar(
        'error'.tr,
        validationError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      isLoading.value = true;
      final activeZones = areas
          .where(
            (area) =>
                area['enabled'] == true && _parsePrice(area['price']) != null,
          )
          .toList();
      if (activeZones.isEmpty) {
        Get.snackbar(
          'warning'.tr,
          'Please enable at least one delivery zone'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }
      final formData = dio.FormData();
      for (int i = 0; i < activeZones.length; i++) {
        final priceValue = _formatPriceForRequest(activeZones[i]['price']);
        final zoneId = activeZones[i]['id'];
        formData.fields.add(
          MapEntry('delivery_zones[$i][delivery_zone_id]', zoneId.toString()),
        );
        formData.fields.add(
          MapEntry('delivery_zones[$i][price]', priceValue),
        );
      }
      formData.fields.add(MapEntry('method', 'put'));
      print('📤 Updating ${activeZones.length} active zones:');
      for (var zone in activeZones) {
        print('   • Zone ${zone['id']} -> ${zone['price']} SYP');
      }
      final response = await ApiService.dio.post(
        '/store/update',
        data: formData,
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      print('📥 Response:');
      print('   • statusCode: ${response.statusCode}');
      print('   • data: ${response.data}');
      if (response.statusCode == 200) {
        await loadDeliveryPrices(showLoading: false);
        Get.snackbar(
          'success'.tr,
          'Prices updated successfully!'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        final data = response.data as Map<String, dynamic>;
        Get.snackbar(
          'error'.tr,
          data['message'] ?? 'Failed to update prices.'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Update Prices Error: $e');
      if (e is dio.DioException) {
        print('📌 Response Data: ${e.response?.data}');
        print('📌 Status Code: ${e.response?.statusCode}');
      }
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

// داخل delivery_price_controller.dart

Future<void> syncMerchantData() async {
  try {
    final token = box.read('token');
    if (token == null) return;

    final response = await ApiService.merchantApi.getStore();
    final storeData = _extractStoreData(response);

    if (storeData != null) {
      // ✅ التحقق من حالة الحظر
      if (storeData['is_blocked'] == true || storeData['blocked'] == true) {
        box.remove('token');
        box.remove('user_data');
        
        // ✅ عرض Dialog
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'account_blocked'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'account_blocked_message'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'contact_support'.tr,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.start);
                },
                child: Text(
                  'okay'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      }

      // ✅ تحديث البيانات إذا كان التاجر غير محظور
      final userData = box.read('user_data') as Map<String, dynamic>? ?? {};
      userData['full_name'] = storeData['full_name'] ?? storeData['store_name'] ?? userData['full_name'] ?? '';
      userData['phone'] = storeData['phone'] ?? storeData['store_phone'] ?? userData['phone'] ?? '';
      userData['social_media'] = storeData['social_media'] ?? userData['social_media'] ?? '';
      userData['store_name'] = storeData['store_name'] ?? userData['store_name'] ?? '';
      userData['store_phone'] = storeData['store_phone'] ?? userData['store_phone'] ?? '';
      userData['location'] = storeData['location'] ?? userData['location'] ?? '';
      userData['description'] = storeData['description'] ?? userData['description'] ?? '';

      box.write('user_data', userData);
      print('✅ Merchant data synced: $userData');
    }
  } catch (e) {
    print('❌ Sync Merchant Data Error: $e');
    
    if (e is DioException) {
      if (e.response?.statusCode == 403) {
        // ✅ حظر
        box.remove('token');
        box.remove('user_data');
        
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'account_blocked'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'account_blocked_message'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'contact_support'.tr,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.start);
                },
                child: Text(
                  'okay'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        
      } else if (e.response?.statusCode == 404) {
        // ✅ حذف
        box.remove('token');
        box.remove('user_data');
        
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'account_deleted'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'account_deleted_message'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'contact_support'.tr,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.start);
                },
                child: Text(
                  'okay'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      }
    }
  }
}

  void _clearTempData() {
    CreateStoreController.clearRegistrationTempData();
  }

  List<dynamic> _extractList(dynamic response, {required List<String> keys}) {
    if (response is List) return response;
    if (response is! Map) return [];

    for (final key in keys) {
      final value = response[key];
      if (value is List) return value;
    }

    final data = response['data'];
    if (data is List) return data;
    if (data is Map) {
      for (final key in keys) {
        final value = data[key];
        if (value is List) return value;
      }
    }

    return [];
  }

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

    return Map<String, dynamic>.from(response);
  }

  Map<String, dynamic>? _extractUserData(Map<String, dynamic> data) {
    final user = data['user'] ?? data['merchant'] ?? data['data'];
    if (user is Map) return Map<String, dynamic>.from(user);
    return null;
  }

  dynamic _zoneIdFromStoreZone(Map zone) {
    final pivot = zone['pivot'];
    return zone['delivery_zone_id'] ??
        zone['deliveryZoneId'] ??
        (pivot is Map ? pivot['delivery_zone_id'] : null) ??
        zone['id'];
  }

  dynamic _priceFromStoreZone(Map zone) {
    final pivot = zone['pivot'];
    return zone['price'] ?? (pivot is Map ? pivot['price'] : null);
  }

  void _syncPriceFromController(int index) {
    if (index >= priceControllers.length || index >= areas.length) return;

    if (areas[index]['enabled'] == true) {
      areas[index]['price'] = priceControllers[index].text.trim();
    } else {
      areas[index]['price'] = '';
      priceControllers[index].clear();
    }
  }

  num? _parsePrice(dynamic value) {
    final text = value.toString().trim().replaceAll(',', '');
    if (text.isEmpty) return null;

    final price = num.tryParse(text);
    if (price == null || price <= 0) return null;

    return price;
  }

  String _formatPriceForRequest(dynamic value) {
    final price = _parsePrice(value) ?? 0;
    if (price % 1 == 0) return price.toInt().toString();
    return price.toString();
  }

  @override
  void onClose() {
    for (var controller in priceControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
