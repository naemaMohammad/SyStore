import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {

  // الكمية
  RxInt quantity = 1.obs;

  // المقاس المختار
  RxString selectedSize = 'M'.obs;

  // اللون المختار
  Rx<Color?> selectedColor = Rx<Color?>(null);

  // المفضلة
  RxBool isFavorite = false.obs;

  // زيادة الكمية
  void increaseQuantity() {
    quantity.value++;
  }

  // إنقاص الكمية
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // تغيير المقاس
  void changeSize(String size) {
    selectedSize.value = size;
  }

  // تغيير اللون
  void changeColor(Color color) {
    selectedColor.value = color;
  }

  // تغيير المفضلة
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}