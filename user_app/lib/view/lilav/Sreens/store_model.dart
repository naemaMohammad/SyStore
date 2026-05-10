import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StoreModel {
  final String name;
  final String category;
  final String image;       
  final String coverImage;   
  final String phoneNumber;
  final String description;
  final double rating;
  final Color bgColor;

  StoreModel({
    required this.name,
    required this.category,
    required this.image,
    required this.coverImage,
    required this.description,
    this.phoneNumber = "0988825012", // قيمة افتراضية
    this.rating = 4.5,
    this.bgColor = Colors.white,
  });

  // (إضافي) دالة لتحويل البيانات من JSON إذا كنت ستجلبها من سيرفر مستقبلاً
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      name: json['name'],
      category: json['category'],
      image: json['image'],
      coverImage: json['coverImage'],
      phoneNumber: json['phoneNumber'] ?? "0988825012",
      rating: (json['rating'] ?? 4.5).toDouble(),
      bgColor: Color(int.parse(json['bgColor'] ?? "0xFFFFFFFF")), description: '',
    );
  }
  static List<StoreModel> allStores = [
  StoreModel(
    name: "MIA",
    category: "Women",
    image: 'assets/images/MIA.jpg',
    coverImage: 'assets/images/store_cover.jpg', // أضيفي مسار صورة الغلاف هنا
    bgColor: Colors.white,
    description: 'store_description'.tr, // يمكنك تحويل هذا أيضاً لباراميتر إذا كان الوصف مختلف لكل محل
  ),
  StoreModel(
    name: "AURA",
    category: "Girl",
    image: 'assets/images/Aura.jpg',
    coverImage: 'assets/images/store_cover.jpg',
    bgColor: const Color(0xFFF6EFE9),
     description: 'store_description'.tr,
  ),
  StoreModel(
    name: "PHANIE",
    category: "Women",
    image: 'assets/images/phanie.jpg',
    coverImage: 'assets/images/store_cover.jpg',
    bgColor: const Color(0xFFF6EFE9),
     description: 'store_description'.tr,
  ),
];
}