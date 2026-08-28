import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/controller/products/product_controller.dart';
import 'package:owner_app/core/constants/filter_catalog.dart';


//هون بس حطيت ال store_id ثابت لازه تغيير
  
class FilterController extends GetxController {
  final ProductController _productController = Get.find<ProductController>();

  
  int? selectedSubCategoryId;
  int? selectedSizeId;
  int? selectedColorId;

  
  final RxnInt selectedParentCategoryId = RxnInt();
  RxString selectedParentCategory = ''.obs;

  
  RxString selectedSubCategory = ''.obs;

  // SIZE 
  RxString selectedSize = ''.obs;

  // COLOR
  Rx<Color?> selectedColor = Rx<Color?>(null);

  // PRICE RANGE
  Rx<RangeValues> priceRange = const RangeValues(0, 10000).obs;

  /// المدى الافتراضي الكامل  نرسل السعر فقط عند الانحراف عنه
  static const RangeValues _defaultPriceRange = RangeValues(0, 10000);
  bool _priceTouched = false;

  // INITIALIZE
  void initialize({
    required String category,
    required double price,
  }) {
    selectedParentCategory.value = category;
    priceRange.value = _defaultPriceRange;
    _priceTouched = false;
  }


  /// لا نُمرّر `category_id` إطلاقاً (السيرفر يُهمله) ولا `store_id`.
  Future<void> applyFilters() async {
    final isPriceDefault =
        priceRange.value.start == _defaultPriceRange.start &&
            priceRange.value.end == _defaultPriceRange.end;
    await _productController.fetchAndFilterProducts(
      category_id: selectedParentCategoryId.value,
      sub_category_id: selectedSubCategoryId,
      size_id: selectedSizeId,
      color_id: selectedColorId,
      min_price: _priceTouched && !isPriceDefault
          ? priceRange.value.start
          : null,
      max_price: _priceTouched && !isPriceDefault
          ? priceRange.value.end
          : null,
    );
  }

  
  
  void changeParentCategory(String name, int id) {
    if (selectedParentCategoryId.value == id) {
      selectedParentCategory.value = '';
      selectedParentCategoryId.value = null;
    } else {
      selectedParentCategory.value = name;
      selectedParentCategoryId.value = id;
    }
    selectedSize.value = '';
    selectedSizeId = null;
  }


  void changeSubCategory(String subCategory) {
    if (selectedSubCategory.value == subCategory) {
      selectedSubCategory.value = '';
      selectedSubCategoryId = null;
    } else {
      selectedSubCategory.value = subCategory;
      selectedSubCategoryId = subCategoryIdFor(subCategory);
    }
  }

  
  void changeSize(String size) {
    if (selectedSize.value == size) {
      selectedSize.value = '';
      selectedSizeId = null;
    } else {
      selectedSize.value = size;
      selectedSizeId = sizeIdFor(selectedParentCategoryId.value, size);
    }
  }

  
  void changeColor(Color color) {
    if (selectedColor.value == color) {
      selectedColor.value = null;
      selectedColorId = null;
    } else {
      selectedColor.value = color;
      selectedColorId =
          kColors.firstWhereOrNull((c) => c.color == color)?.id;
    }
  }

  // PRICE
  void updatePriceRange(RangeValues newRange) {
    double start = (newRange.start / 50).round() * 50.0;
    double end = (newRange.end / 50).round() * 50.0;

    if (start < 0) start = 0;
    if (end > 10000) end = 10000;

    priceRange.value = RangeValues(start, end);
    _priceTouched = true;
  }

  // CLEAR إعادة ضبط الواجهة 
  void clearFilters() {
    selectedParentCategory.value = '';
    selectedSubCategory.value = '';
    selectedSize.value = '';
    selectedColor.value = null;
    priceRange.value = _defaultPriceRange;

    selectedParentCategoryId.value = null;
    selectedSubCategoryId = null;
    selectedSizeId = null;
    selectedColorId = null;
    _priceTouched = false;
  }
}
