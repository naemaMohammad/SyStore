import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {

  //CATEGORY
  RxString selectedCategory = ''.obs;

  // SIZE
  RxString selectedSize = ''.obs;

  // AGE GROUP
  RxString selectedAgeGroup = ''.obs;

  // COLOR
  Rx<Color?> selectedColor = Rx<Color?>(null);

  // PRICE RANGE
  Rx<RangeValues> priceRange =
      const RangeValues(10, 1000).obs;

  // INITIALIZE
  void initialize({
    required String category,
    required double price,
  }) {

    selectedCategory.value = category;

    priceRange.value =
        RangeValues(10, price);
  }

  // CATEGORY
  void changeCategory(String category) {

    if (selectedCategory.value == category) {

      selectedCategory.value = '';

    } else {

      selectedCategory.value = category;
    }
  }

  // SIZE
  void changeSize(String size) {

    if (selectedSize.value == size) {

      selectedSize.value = '';

    } else {

      selectedSize.value = size;
    }
  }

  // AGE GROUP
  void changeAgeGroup(String group) {

    if (selectedAgeGroup.value == group) {

      selectedAgeGroup.value = '';

    } else {

      selectedAgeGroup.value = group;
    }

    // reset size
    selectedSize.value = '';
  }

  // COLOR
  void changeColor(Color color) {

    if (selectedColor.value == color) {

      selectedColor.value = null;

    } else {

      selectedColor.value = color;
    }
  }

  // PRICE
  void updatePriceRange(
    RangeValues newRange,
  ) {

    double start =
        (newRange.start / 50).round() * 50.0;

    double end =
        (newRange.end / 50).round() * 50.0;

    if (start < 10) start = 10;

    if (end > 1000) end = 1000;

    priceRange.value =
        RangeValues(start, end);
  }

  // CLEAR
  void clearFilters() {

    selectedCategory.value = '';

    selectedSize.value = '';

    selectedAgeGroup.value = '';

    selectedColor.value = null;

    priceRange.value =
        const RangeValues(10, 1000);
  }
}