import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/lilav/Sreens/all_stores_screen.dart';


class AllStoresController extends GetxController {

  // التصنيفات
  final List<String> categories = [
    "all".tr,
    "Women".tr,
    "Men".tr,
    "Girl".tr,
    "Boy".tr,
  ];

  // التصنيف المختار
  RxString selectedCategory = "all".tr.obs;

  // جميع المتاجر
  final List<StoreData> allStores = [
    StoreData(
      name: "MIA",
      category: "Women",
      image: 'assets/images/MIA.jpg',
      bgColor: Colors.white,
    ),

    StoreData(
      name: "AURA",
      category: "Women",
      image: 'assets/images/Aura.jpg',
      bgColor: const Color(0xFFF6EFE9),
    ),

    StoreData(
      name: "PHANIE",
      category: "Women",
      image: 'assets/images/phanie.jpg',
      bgColor: const Color(0xFFF6EFE9),
    ),
  ];

  // تغيير التصنيف
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // المتاجر المفلترة
  List<StoreData> get filteredStores {
    if (selectedCategory.value == "all".tr) {
      return allStores;
    }

    return allStores
        .where((store) => store.category == selectedCategory.value)
        .toList();
  }
}