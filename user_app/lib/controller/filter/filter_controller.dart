import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/core/constants/filter_catalog.dart';

class FilterController extends GetxController {
 
  RxString selectedParentCategory = ''.obs;
  final RxnInt selectedParentCategoryId = RxnInt();

  RxString selectedSubCategory = ''.obs;
  int? selectedSubCategoryId;

  RxString selectedSize = ''.obs;
  int? selectedSizeId;

  Rx<Color?> selectedColor = Rx<Color?>(null);
  int? selectedColorId;

  var priceRange = const RangeValues(0, 10000).obs;

  static const RangeValues _defaultPriceRange = RangeValues(0, 10000);
  bool _priceTouched = false;

  void initialize({
    required String category,
    required double price,
  }) {
    selectedParentCategory.value = category;
    priceRange.value = _defaultPriceRange;
    _priceTouched = false;
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

  // COLOR
  void changeColor(Color color) {
    if (selectedColor.value == color) {
      selectedColor.value = null;
      selectedColorId = null;
    } else {
      selectedColor.value = color;
      selectedColorId = _colorIdFor(color);
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

  static int? _colorIdFor(Color color) {
    for (final c in kColors) {
      if (c.hex == color) return c.id;
    }
    return null;
  }

 
  Map<String, dynamic> buildParams({required int storeId}) {
    final isPriceDefault =
        priceRange.value.start == _defaultPriceRange.start &&
            priceRange.value.end == _defaultPriceRange.end;
    final sendPrice = _priceTouched && !isPriceDefault;

    final params = <String, dynamic>{
      'store_id': storeId,
      if (selectedSubCategoryId != null)
        'sub_category_id': selectedSubCategoryId,
      if (selectedSizeId != null) 'size_id': selectedSizeId,
      if (selectedColorId != null) 'color_id': selectedColorId,
      if (sendPrice) 'min_price': priceRange.value.start.round(),
      if (sendPrice) 'max_price': priceRange.value.end.round(),
    };
    return params;
  }


  bool get hasActiveFilters =>
      selectedParentCategoryId.value != null ||
      selectedSubCategoryId != null ||
      selectedSizeId != null ||
      selectedColorId != null;

 
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
