import 'dart:io';

import 'package:dio/dio.dart' as src_dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/data/data_source/api_calls.dart';
import 'package:owner_app/data/model/StoreModel.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/data/services/token_service.dart';

class StoreController extends GetxController {
  // نفس نسخة الـ ApiCalls المشتركة (المسجّلة في ApiService.init).
  final ApiCalls _apiCalls = ApiService.apiCalls;

  var isLoading = false.obs;
  Rxn<StoreModel> storeModel = Rxn<StoreModel>();
  RxBool isEditing = false.obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxString tempLogoPath = ''.obs;
  RxString tempCoverPath = ''.obs;
  // التوكن الآن يُؤخذ من TokenService الموحّد (لا توكن ثابت بعد الآن).
  String get _token => Get.find<TokenService>().bearer;

  @override
  void onInit() {
    super.onInit();
    fetchStoreData(); // جلب بيانات المتجر فور تشغيل الكونترولر
  }

  // تابع جلب بيانات المتجر من السيرفر (GET)
  void fetchStoreData() async {
    
    try {
      isLoading(true);
      final response = await _apiCalls.getMerchantStore();
       storeModel.value = response;
print("=================================");
print("STORE CATEGORIES:");
print(response.store?.categories);
print("CATEGORY COUNT:");
print(response.store?.categories?.length);
print("CATEGORY IDS:");

for (final category in response.store?.categories ?? []) {
  print("ID: ${category.id} | TYPE: ${category.type}");
}

print("=================================");
     
      print(response.toJson());
      print("تم جلب بيانات المتجر بنجاح: ${response.store?.storeName}");
    } on src_dio.DioException catch (e) {
      print("STATUS = ${e.response?.statusCode}");
      print("DATA = ${e.response?.data}");
      print("MESSAGE = ${e.message}");
    } catch (e) {
      print(e);
      Get.snackbar("error".tr, "failed_fetch_store".tr);
    } finally {
      isLoading(false);
    }
  }

  //  دالة موحدة لاختيار الصور (سواء لوجو أو غلاف)
  Future<void> pickImageFromGallery({required bool isLogo}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (isLogo) {
        //اذا كان المختار لوغو
        tempLogoPath.value = image.path;
      } else {
        //اذا مو لوغو ف حيكون الغلاف
        tempCoverPath.value = image.path;
      }
    }
  }

  Future<void> updateStoreInfoApi({
    required String name,
    required String description,
    required String phone,
    String? logoPath,
    String? coverPath,
  }) async {
    try {
      isLoading(true);

      //  بناء كائن FormData
      src_dio.FormData formData = src_dio.FormData.fromMap({
        "store_name": name,
        "description": description,
        "store_phone": phone,
        "method": "put",
      });

      //  إضافة مصفوفة الـ category_ids
      final categoriesMap = {
        'men': '1',
        'women': '2',
        'boys': '3',
        'girls': '4',
      };
      int index = 0;
      for (var catName in selectedCategories) {
        if (categoriesMap[catName] != null) {
          formData.fields.add(
            MapEntry("category_ids[$index]", categoriesMap[catName]!),
          );
          index++;
        }
      }

      //  إضافة ملف صورة اللوجو
      //  إضافة ملف صورة اللوجو (إذا تم اختيار صورة جديدة محلياً)
      if (tempLogoPath.value.isNotEmpty &&
          File(tempLogoPath.value).existsSync()) {
        formData.files.add(
          MapEntry(
            "logo_image",
            await src_dio.MultipartFile.fromFile(
              tempLogoPath.value,
              filename: tempLogoPath.value.split('/').last,
            ),
          ),
        );
      }

      // إضافة ملف صورة الغلاف

      if (tempCoverPath.value.isNotEmpty &&
          File(tempCoverPath.value).existsSync()) {
        formData.files.add(
          MapEntry(
            "cover_image",
            await src_dio.MultipartFile.fromFile(
              tempCoverPath.value,
              filename: tempCoverPath.value.split('/').last,
            ),
          ),
        );
      }

      //️ الاستدعاء
      final updatedResponse = await _apiCalls.updateStore(
        storeData: formData, // نمرر formData بالكامل
      );

      storeModel.value = updatedResponse;

      isEditing(false);
      Get.snackbar("success".tr, "store_updated".tr);
    } catch (e) {
      Get.snackbar(
        "error".tr,
        ApiService.errorMessage(e, fallback: "failed_update_store".tr),
      );
      print("Update Store Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
