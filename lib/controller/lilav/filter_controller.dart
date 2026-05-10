import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {

  // القسم المختار
  RxString selectedCategory = ''.obs;

  // السعر
  RxDouble currentPrice = 1000.0.obs;

  // المقاس
  RxString selectedSize = 'M'.obs;

  // اللون
  Rx<Color?> selectedColor = Rx<Color?>(null);

  // تهيئة القيم الأولى
  void initialize({
    required String category,
    required double price,
  }) {
    selectedCategory.value = category;
    currentPrice.value = price;
  }

  // تغيير القسم
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // تغيير المقاس
  void changeSize(String size) {
    selectedSize.value = size;
  }

  // تغيير اللون
  void changeColor(Color color) {
    selectedColor.value = color;
  }

  // تغيير السعر
  void changePrice(double price) {
    currentPrice.value = price;
  }

  // إعادة ضبط الفلاتر
  void clearFilters() {
    selectedCategory.value = 'all'.tr;
    currentPrice.value = 1000;
    selectedSize.value = 'M';
    selectedColor.value = null;
  }
}