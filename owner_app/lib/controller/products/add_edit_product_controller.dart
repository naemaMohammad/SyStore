import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner_app/controller/products/product_controller.dart';
import 'package:owner_app/controller/stores/store_controller.dart';
import 'package:owner_app/data/data_source/api_calls.dart';
import 'package:owner_app/data/data_source/api_constants.dart';
import 'package:owner_app/data/model/CategoryModel.dart';
import 'package:owner_app/data/model/Colors_Model.dart';
import 'package:owner_app/data/model/ProductModel.dart';
import 'package:owner_app/data/model/product_variant_model.dart';
import 'package:owner_app/data/services/api_service.dart';
import 'package:owner_app/data/services/token_service.dart';
import 'package:dio/dio.dart' as dio_package;

class AddProductController extends GetxController {
final ApiCalls _apiService = ApiService.apiCalls;
    String get _token => Get.find<TokenService>().bearer;

  // تيكست كونترولرز الأساسية
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final materialController = TextEditingController();
  final priceController = TextEditingController();

  Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  Rx<SubCategoryModel?> selectedProductType = Rx<SubCategoryModel?>(null);

  RxString imagePath = ''.obs;
  Rx<ProductVariant?> currentVariant = Rx<ProductVariant?>(null);
  RxList<AppColorModel> selectedColors = <AppColorModel>[].obs;
  RxList<String> selectedSizes = <String>[].obs;
  RxBool isCreatingVariant = false.obs;

  int? editingVariantIndex;

  int? getSizeId(String sizeName) {
    switch (selectedCategory.value!.id) {
      case 1: // men
        switch (sizeName) {
          case "S":
            return 1;
          case "M":
            return 2;
          case "L":
            return 3;
          case "XL":
            return 4;
          case "XXL":
            return 5;
          case "Free":
            return 6;
        }

      case 2: // women
        switch (sizeName) {
          case "S":
            return 7;
          case "M":
            return 8;
          case "L":
            return 9;
          case "XL":
            return 10;
          case "XXL":
            return 11;
          case "Free":
            return 12;
        }

      case 3: // boys
        switch (sizeName) {
          case "8Y":
            return 13;
          case "10Y":
            return 14;
          case "12Y":
            return 15;
          case "14Y":
            return 16;
          case "16Y":
            return 17;
          case "Free":
            return 18;
        }

      case 4: // girls
        switch (sizeName) {
          case "8Y":
            return 19;
          case "10Y":
            return 20;
          case "12Y":
            return 21;
          case "14Y":
            return 22;
          case "16Y":
            return 23;
          case "Free":
            return 24;
        }
    }

    return null;
  }

  final List<String> sizes = ["S", "M", "L", "XL", "Free"];
  final List<String> adultSizes = ['S', 'M', 'L', 'XL', 'XXL', "Free"];
  
  final List<String> kidsSizes = ['8Y', '10Y', '12Y', '14Y', '16Y', 'Free'];

  
  final List<AppColorModel> availableColors = [
    AppColorModel(id: 1, name: 'Gray', color: const Color(0xFFF0F0F0)),
    AppColorModel(id: 2, name: 'White', color: const Color(0xFFFFFFFF)),
    AppColorModel(id: 3, name: 'Black', color: const Color(0xFF000000)),
    AppColorModel(id: 4, name: 'Maroon', color: const Color(0xFF8B1A1A)),
    AppColorModel(id: 5, name: 'Red', color: const Color(0xFFFF3131)),
    AppColorModel(id: 6, name: 'Baby Pink', color: const Color(0xFFFFABAB)),
    AppColorModel(id: 7, name: 'Brown', color: const Color(0xFF5D4037)),
    AppColorModel(id: 8, name: 'Yellow', color: const Color(0xFFFFF59D)),
    AppColorModel(id: 9, name: 'Orange', color: const Color(0xFFE67E22)),
    AppColorModel(id: 10, name: 'Beige', color: const Color(0xFFD7CCC8)),
    AppColorModel(id: 11, name: 'Baby Blue', color: const Color(0xFF81D4FA)),
    AppColorModel(id: 12, name: 'Blue', color: const Color(0xFF1A237E)),
    AppColorModel(id: 13, name: 'Baby Green', color: const Color(0xFFA5D6A7)),
    AppColorModel(id: 14, name: 'Green', color: const Color(0xFF00897B)),
    AppColorModel(id: 15, name: 'Baby Purple', color: const Color(0xFFE1BEE7)),
    AppColorModel(id: 16, name: 'Purple', color: const Color(0xFF8E24AA)),
    AppColorModel(id: 17, name: 'Pink', color: const Color(0xFFD81B60)),
  ];

  final List<CategoryModel> categories = [
    CategoryModel(id: 1, name: 'men'),
    CategoryModel(id: 2, name: 'women'),
    CategoryModel(id: 3, name: 'boys'),
    CategoryModel(id: 4, name: 'girls'),
  ];

  final List<SubCategoryModel> productTypes = [
    SubCategoryModel(id: 1,  name: 'tshirt'),
    SubCategoryModel(id: 2,  name: 'jacket'),
    SubCategoryModel(id: 3,  name: 'hoodie'),
    SubCategoryModel(id: 4, name: 'dress'),
    SubCategoryModel(id: 5,  name: 'skirt'),
    SubCategoryModel(id: 6,  name: 'sweater'),
    SubCategoryModel(id: 7,  name: 'set'),
    SubCategoryModel(id: 8,  name: 'abaya'),
    SubCategoryModel(id: 9,  name: 'shorts'),
    SubCategoryModel(id: 10, name: 'pants'),
  ];

  RxList<ProductVariant> variants = <ProductVariant>[].obs;
  Rx<AppColorModel?> selectedVariantColor = Rx<AppColorModel?>(null);
  RxList<String> variantImages = <String>[].obs;
  RxMap<String, TextEditingController> inventoryControllers =
      <String, TextEditingController>{}.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    inventoryControllers['S'] = TextEditingController();
    inventoryControllers['M'] = TextEditingController();
    inventoryControllers['L'] = TextEditingController();
    inventoryControllers['XL'] = TextEditingController();
  }


 // 🛠️ تابع الإضافة والتعديل 
  Future<bool> saveProductToApi({
    bool isEditMode = false,
    int? editProductId,
  }) async {
    final productController = Get.find<ProductController>();

  
    if (variants.isEmpty) {
      Get.snackbar("error".tr, "add_at_least_one_color".tr);
      return false;
    }

    //  Primary Cover Image validation:
    //    The first image of the first variant is treated as the product's
    //    primary cover image, so it MUST exist before submitting.
    if (variants.first.images.isEmpty) {
      Get.snackbar(
        "error".tr,
        "primary_cover_image_required".tr,
      );
      return false;
    }

    //  Mandatory color-to-image mapping:
    //    EVERY selected color (variant) must have at least one image.
    final variantsWithoutImages =
        variants.where((v) => v.images.isEmpty).toList();
    if (variantsWithoutImages.isNotEmpty) {
      Get.snackbar(
        "error".tr,
        "image_per_color_required".tr,
      );
      return false;
    }

    if (selectedCategory.value == null || selectedProductType.value == null) {
      Get.snackbar("error".tr, "select_category_and_type".tr);
      return false;
    }

    try {
      isLoading(true);

      dio_package.FormData formData = dio_package.FormData();

      
      //  معرّف متجر التاجر يُؤخذ ديناميكياً من المتجر المحمّل في StoreController
      //  (كان مكتوباً ثابتاً "2" قبل الدمج). إذا لم يكن محمّلاً بعد نحاول
      //  جلبه الآن لضمان إسناد المنتج للمتجر الصحيح.
      final storeId = _currentStoreId();

      formData.fields.addAll([
        MapEntry("store_id", storeId),
        MapEntry("name", nameController.text.trim()),
        MapEntry("description", descriptionController.text.trim()),
        MapEntry("price", priceController.text.trim()),
        MapEntry("material", materialController.text.trim()),
        MapEntry("category_id", selectedCategory.value!.id.toString()),
        MapEntry("sub_category_id", selectedProductType.value!.id.toString()),
      ]);

      if (isEditMode) {
        formData.fields.add(const MapEntry("_method", "PUT"));
      }

      
      final mainPath = _pathOf(variants.first.images.first);
      if (_isLocalFile(mainPath)) {
      
        formData.files.add(MapEntry("image", await _multipart(mainPath)));
      } else if (isEditMode && mainPath.isNotEmpty) {
        //  صورة سيرفر قديمة → نخبر الـ backend بالاحتفاظ بها بدل استبدالها
        formData.fields.add(MapEntry("existing_image", mainPath));
      }

      
      //    variants[i][color_id]
      //    variants[i][images][]         ← ملفات الصور لهذا اللون
      //    variants[i][sizes][j][size_id] / [quantity]    ← المقاسات والكميات
      //   الـ backend يقرأ $variant['sizes'] كمفتاح متداخل، فلا تُسطّح المفاتيح.
      for (int i = 0; i < variants.length; i++) {
        final variant = variants[i];
        final String colorId = variant.colorId?.toString() ?? "1";

        //  معرّف اللون لهذا الـ variant
        formData.fields.add(MapEntry("variants[$i][color_id]", colorId));

        // صور الـ variant تحت variants[i][images][] (ملفات جديدة) —
      
        for (int j = 0; j < variant.images.length; j++) {
          final path = _pathOf(variant.images[j]);
          if (path.isEmpty) continue;

          if (_isLocalFile(path)) {
            //  صورة جديدة 
            formData.files.add(MapEntry(
              "variants[$i][images][$j]",
              await _multipart(path),
            ));
         } else if (isEditMode) {
  // صورة قديمة:
  // Flutter يستخدم URL الكامل للعرض،
  // لكن الـ backend يريد storage path فقط.
  final existingPath = _storagePathFromImageUrl(path);

  if (existingPath.isNotEmpty) {
    formData.fields.add(
      MapEntry(
        "variants[$i][existing_images][$j]",
        existingPath,
      ),
    );
  }
}
        }

        //  المقاسات والكميات ضمن variants[i][sizes][j][...]
    //    id هو المفتاح الأساسي الفعلي من جدول sizes المرتبط بال category.
        int sizeIdx = 0;
        variant.stock.forEach((sizeName, quantity) {
          final id = getSizeId(sizeName);
          if (id != null && quantity > 0) {
            formData.fields.add(MapEntry(
              "variants[$i][sizes][$sizeIdx][size_id]", id.toString()));
            formData.fields.add(MapEntry(
              "variants[$i][sizes][$sizeIdx][quantity]", quantity.toString()));
            sizeIdx++;
          }
        });
      }

      
      for (var element in formData.fields) {
        print("FIELD: ${element.key} = ${element.value}");
      }
      print("TOTAL FILES TO SEND: ${formData.files.length}");

    if (isEditMode && editProductId != null) {
        await productController.updateProductInfo(
          productId: editProductId,
          productData: formData,
        );
      } else {
      await productController.addProduct(formData );
      }
      return true;
   } on dio_package.DioException catch (e) {
    
    print("❌ LARAVEL ERROR DETAILS: ${e.response?.data}");
    return false;

  } catch (e) {
    print("Error sending data: $e");
    Get.snackbar("error".tr, "failed_to_add_product".tr);
    return false;
  } finally {
    isLoading(false);
  }
  }

  //  دوال مساعدة لبناء الـ FormData بشكل نظيف

  /// يرجع معرّف متجر التاجر الحالي محمّلاً من StoreController،
  /// ويسحب بيانات المتجر إن لم تكن محمّلة بعد. يرجع "2" كحل أخير
  /// مطابق للسلوك السابق لتجنب كسر الإرسال قبل توفّر المعرف.
  String _currentStoreId() {
    try {
      if (Get.isRegistered<StoreController>()) {
        final storeController = Get.find<StoreController>();
        final store = storeController.storeModel.value?.store;
        if (store != null && store.id != null) {
          return store.id.toString();
        }
      }
    } catch (e) {
      print("Error resolving store id: $e");
    }
    return "2";
  }
String _storagePathFromImageUrl(String path) {
  if (path.isEmpty) return '';

  final uri = Uri.tryParse(path);

  if (uri != null && uri.path.contains('/storage/')) {
    final storageIndex = uri.path.indexOf('/storage/');

    return uri.path
        .substring(storageIndex + '/storage/'.length)
        .replaceFirst(RegExp(r'^/+'), '');
  }

  if (path.startsWith('Uploads/')) {
    return path;
  }

  return path;
}
  /// يرجع المسار النصّي سواء كان العنصر String أو XFile
  String _pathOf(dynamic img) =>
      (img is String) ? img : (img as dynamic).path.toString();

  /// يحدد إن كانت الصورة ملفاً محليّاً جديداً من الجهاز (وليست رابطاً/مساراً من السيرفر)
  bool _isLocalFile(String p) =>
      p.isNotEmpty &&
      !p.startsWith('http') &&
      !p.startsWith('Uploads/') &&
      !p.startsWith('uploads/') &&
      !p.contains('storage/');

  /// يبني MultipartFile مع التعامل مع فاصل المسار العكسي على ويندوز
  Future<dio_package.MultipartFile> _multipart(String path) =>
      dio_package.MultipartFile.fromFile(
        path,
        filename: path.split(RegExp(r'[/\\]')).last,
      );

Future<Product?> fetchProductDetails(int productId) async {
    try {
      
      ProductModel response = await _apiService.getProductDetails(productId);
      
      if (response.status == true && response.product != null) {
        return response.product;
      }
      return null;
    } catch (e) {
      print("Error fetching product via Retrofit: $e");
      return null;
    }
  }

  void clearData() {
    nameController.clear();
    descriptionController.clear();
    materialController.clear();
    priceController.clear();
    selectedCategory.value = null;
    selectedProductType.value = null;
    selectedSizes.clear();
    variants.clear();
    imagePath.value = '';
  }

  void toggleSize(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
    } else {
      selectedSizes.add(size);
    }
  }

  void toggleColor(AppColorModel appColor) {
    if (selectedColors.contains(appColor)) {
      selectedColors.remove(appColor);
    } else {
      selectedColors.add(appColor);
    }
  }

 void selectCategory(CategoryModel category) {
  selectedCategory.value = category;
}

  void selectProductType(SubCategoryModel type) {
    selectedProductType.value = type;
  }

  void selectImage(String path) {
    imagePath.value = path;
  }

  List<String> get currentSizes {
    if (selectedCategory.value?.name == 'girls' ||
        selectedCategory.value?.name == 'boys') {
      return kidsSizes;
    }
    return adultSizes;
  }

  void addVariant() {
    editingVariantIndex = null;
     currentVariant.value = ProductVariant(
    color: null,
    colorId: null,
    images: [],
    stock: {},
  );

  }

  void removeVariant(int index) {
    variants.removeAt(index);
  }

  void selectVariantColor(AppColorModel appColor) {
    
    selectedVariantColor.value = appColor;
    if (currentVariant.value != null) {
      currentVariant.value!.color = appColor.color;
      currentVariant.value!.colorId =
          appColor.id; 
      currentVariant.refresh();
    }
    variants.refresh();
  }

  Future<void> addVariantImage() async {
    if (currentVariant.value == null) {
      Get.snackbar(
        "error".tr,
        "select_color_first".tr,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      currentVariant.value!.images.add(image.path);
      currentVariant.refresh();
      variants.refresh();
    }
  }

  void removeVariantImage(int imageIndex) {
    currentVariant.value!.images.removeAt(imageIndex);
    currentVariant.refresh();
  }

  void updateStock(String size, String value) {
    currentVariant.value!.stock[size] = int.tryParse(value) ?? 0;
    currentVariant.refresh();
  }
  void saveVariantData(int index, Map<String, int> updatedStock) {
  // تحديث الـ stock الخاص بالـ variant المحدد بناءً على التعديلات الجديدة فقط
  variants[index].stock = updatedStock;
  variants.refresh();
  update();
}

  void saveCurrentVariant() {
    if (currentVariant.value == null) return;
   final updatedVariant = ProductVariant(
    color: currentVariant.value!.color,
    colorId: currentVariant.value!.colorId,
    images: List.from(currentVariant.value!.images),
    stock: Map.from(currentVariant.value!.stock),
  );

  if (editingVariantIndex != null) {
    //  إذا كنا نعدل عنصر موجود مسبقاً، نستبدله عند نفس الأندكس المختار
    variants[editingVariantIndex!] = updatedVariant;
  } else {
    // إذا كان عنصراً جديداً كلياً، نضيفه نهاية المصفوفة
    variants.add(updatedVariant);
  }
    currentVariant.value = null;
    selectedVariantColor.value = null;
    editingVariantIndex = null;
    variants.refresh();
  }

void setProductForEdit(Product product) {

  print("DEBUG: Clicking Edit for product: ${product.name}");
  print("DEBUG: raw productImages from store page -> ${product.productImages}");
  print("DEBUG: raw productVariants from store page -> ${product.productVariants}");

  // 1. تصفير المتغيرات النصية وقائمة الـ variants الحالية فقط 
  clearData(); 

  // 1. تعبئة الحقول النصية
  nameController.text = product.name ?? '';
  descriptionController.text = product.description ?? '';
  materialController.text = product.material ?? '';
  priceController.text = product.price ?? '';

  // 2. اختيار القسم والنوع المطابق

  //    (int أو String أو null)، فنحوّلها إلى int قبل المقارنة مع الـ IDs
  final int? catId = int.tryParse('${product.categoryId}');
  final int? subId = int.tryParse('${product.subCategoryId}');
  selectedCategory.value =
      categories.firstWhereOrNull((c) => c.id == catId);
  selectedProductType.value =
      productTypes.firstWhereOrNull((t) => t.id == subId);
  print("DEBUG: restore -> categoryId=$catId, subCategoryId=$subId, "
      "selectedCategory=${selectedCategory.value?.name}, "
      "selectedProductType=${selectedProductType.value?.name}");

  // 3. دمج خرائط الألوان والمقاسات محلياً
  List<int> uniqueColorIds = [];
  Map<int, List<String>> colorImagesMap = {};
  Map<int, Map<String, int>> colorStockMap = {};

  //   دعم قراءة المقاسات سواء جاءت من الكرت (productVariants) أو تفاصيل السيرفر (variants الخام)
  var rawVariants = product.productVariants ?? product.toJson()['variants'] as List<dynamic>?;

  if (rawVariants != null) {
    for (var v in rawVariants) {
      int? cId = int.tryParse(v['color_id']?.toString() ?? '');
      if (cId != null) {
        if (!uniqueColorIds.contains(cId)) {
          uniqueColorIds.add(cId);
        }
        
        String sizeName = v['size']?.toString() ?? getSizeNameFromId(int.tryParse(v['size_id']?.toString() ?? '') ?? 0);
        int quantity = int.tryParse(v['quantity']?.toString() ?? '0') ?? 0;
        
        if (!colorStockMap.containsKey(cId)) {
          colorStockMap[cId] = {};
        }
        colorStockMap[cId]![sizeName] = quantity;
      }
    }
  }

  //   دعم قراءة الصور سواء جاءت من الكرت (productImages) أو تفاصيل السيرفر (images الخام)
  var rawImages = product.productImages ?? product.toJson()['images'] as List<dynamic>?;
final String domain = ApiConstants.baseUrl.replaceAll('/api', '');
  if (rawImages != null) {
    for (var img in rawImages) {
      int? cId = int.tryParse(img['color_id']?.toString() ?? '');
      if (cId != null) {
        if (!uniqueColorIds.contains(cId)) {
          uniqueColorIds.add(cId);
        }
        
        if (!colorImagesMap.containsKey(cId)) {
          colorImagesMap[cId] = [];
        }
       String imgPath = img['image']?.toString() ?? '';
if (imgPath.isNotEmpty) {
  String fullImagePath = imgPath;
  
  
  if (!imgPath.startsWith('http')) {
    if (imgPath.startsWith('Uploads/')) {
      fullImagePath = "$domain/storage/$imgPath"; 
    } else {
      fullImagePath = "$domain$imgPath";
    }
  }

  if (!colorImagesMap[cId]!.contains(fullImagePath)) {
    colorImagesMap[cId]!.add(fullImagePath);
  }
}
    }}
  }

  // 4. بناء الـ ProductVariant النهائي وعرضه بالواجهة 
  for (int cId in uniqueColorIds) {
    AppColorModel? matchedColor = availableColors.firstWhereOrNull((c) => c.id == cId);

    variants.add(ProductVariant(
      colorId: cId,
      color: matchedColor?.color, 
      images: colorImagesMap[cId] ?? [],
      stock: colorStockMap[cId] ?? {},
    ));
  }

  variants.refresh();
  update(); 
}

// دالة مساعدة لعكس الـ ID وجلب اسم المقاس المناسب في الواجهة
String getSizeNameFromId(int id) {
  if (id == 1 || id == 7) return "S";
  if (id == 2 || id == 8) return "M";
  if (id == 3 || id == 9) return "L";
  if (id == 4 || id == 10) return "XL";
  if (id == 5 || id == 11) return "XXL";
  if (id == 6 || id == 12) return "Free";
  //  boys (13-18) و girls (19-24) 
  if (id == 13 || id == 19) return "8Y";
  if (id == 14 || id == 20) return "10Y";
  if (id == 15 || id == 21) return "12Y";
  if (id == 16 || id == 22) return "14Y";
  if (id == 17 || id == 23) return "16Y";
  if (id == 18 || id == 24) return "Free";
  return "Free";
}
String? validateProduct() {
  if (nameController.text.trim().isEmpty) {
    return 'enter_product_name'.tr;
  }

  if (priceController.text.trim().isEmpty) {
    return 'enter_product_price'.tr;
  }

  final price = double.tryParse(priceController.text.trim());
  if (price == null || price <= 0) {
    return 'enter_valid_product_price'.tr;
  }

  if (selectedCategory.value == null) {
    return 'choose_category'.tr;
  }

  if (selectedProductType.value == null) {
    return 'choose_product_type'.tr;
  }

  if (materialController.text.trim().isEmpty) {
    return 'enter_product_material'.tr;
  }

  if (descriptionController.text.trim().isEmpty) {
    return 'enter_product_description'.tr;
  }

  if (variants.isEmpty) {
    return 'add_at_least_one_variant'.tr;
  }

  for (final variant in variants) {
    if (variant.colorId == null) {
      return 'choose_color_for_variant'.tr;
    }

    if (variant.images.isEmpty) {
      return 'add_image_for_variant'.tr;
    }

    if (variant.stock.isEmpty) {
      return 'choose_size_for_variant'.tr;
    }

    final hasQuantity = variant.stock.values.any((q) => q > 0);
    if (!hasQuantity) {
      return 'enter_quantity_for_sizes'.tr;
    }
  }

  return null;
}
  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    materialController.dispose();
    priceController.dispose();
    inventoryControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
}
