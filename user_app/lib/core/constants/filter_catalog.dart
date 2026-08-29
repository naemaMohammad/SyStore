library;

import 'package:flutter/material.dart';


class CategoryEntry {
  final int id;
  final String name;
  const CategoryEntry({required this.id, required this.name});
}


class SubCategoryEntry {
  final int id;
  final String name;
  const SubCategoryEntry({required this.id, required this.name});
}

class ColorEntry {
  final int id;
  final String name;
  final Color hex;
  const ColorEntry({required this.id, required this.name, required this.hex});
}

const List<CategoryEntry> kCategories = [
  CategoryEntry(id: 1, name: 'men'),
  CategoryEntry(id: 2, name: 'women'),
  CategoryEntry(id: 3, name: 'boys'),
  CategoryEntry(id: 4, name: 'girls'),
];

const List<SubCategoryEntry> kSubCategories = [
  SubCategoryEntry(id: 1, name: 'T-Shirts'),
  SubCategoryEntry(id: 2, name: 'Jacket'),
  SubCategoryEntry(id: 3, name: 'Hoodie'),
  SubCategoryEntry(id: 4, name: 'Dress'),
  SubCategoryEntry(id: 5, name: 'Skirt'),
  SubCategoryEntry(id: 6, name: 'Sweater'),
  SubCategoryEntry(id: 7, name: 'Set'),
  SubCategoryEntry(id: 8, name: 'Abaya'),
  SubCategoryEntry(id: 9, name: 'Shorts'),
  SubCategoryEntry(id: 10, name: 'Pants'),
];


const Map<int, Map<String, int>> kSizesByCategory = {
  1: {'S': 1, 'M': 2, 'L': 3, 'XL': 4, 'XXL': 5, 'Free': 6}, // men
  2: {'S': 7, 'M': 8, 'L': 9, 'XL': 10, 'XXL': 11, 'Free': 12}, // women
  3: {'8Y': 13, '10Y': 14, '12Y': 15, '14Y': 16, '16Y': 17, 'Free': 18}, // boys
  4: {'8Y': 19, '10Y': 20, '12Y': 21, '14Y': 22, '16Y': 23, 'Free': 24}, // girls
};


const List<ColorEntry> kColors = [
  ColorEntry(id: 1, name: 'Gray', hex: Color(0xFFF0F0F0)),
  ColorEntry(id: 2, name: 'White', hex: Color(0xFFFFFFFF)),
  ColorEntry(id: 3, name: 'Black', hex: Color(0xFF000000)),
  ColorEntry(id: 4, name: 'Maroon', hex: Color(0xFF8B1A1A)),
  ColorEntry(id: 5, name: 'Red', hex: Color(0xFFFF3131)),
  ColorEntry(id: 6, name: 'Baby Pink', hex: Color(0xFFFFABAB)),
  ColorEntry(id: 7, name: 'Brown', hex: Color(0xFF5D4037)),
  ColorEntry(id: 8, name: 'Yellow', hex: Color(0xFFFFF59D)),
  ColorEntry(id: 9, name: 'Orange', hex: Color(0xFFE67E22)),
  ColorEntry(id: 10, name: 'Beige', hex: Color(0xFFD7CCC8)),
  ColorEntry(id: 11, name: 'Baby Blue', hex: Color(0xFF81D4FA)),
  ColorEntry(id: 12, name: 'Blue', hex: Color(0xFF1A237E)),
  ColorEntry(id: 13, name: 'Baby Green', hex: Color(0xFFA5D6A7)),
  ColorEntry(id: 14, name: 'Green', hex: Color(0xFF00897B)),
  ColorEntry(id: 15, name: 'Baby Purple', hex: Color(0xFFE1BEE7)),
  ColorEntry(id: 16, name: 'Purple', hex: Color(0xFF8E24AA)),
  ColorEntry(id: 17, name: 'Pink', hex: Color(0xFFD81B60)),
];


const List<String> kSubCategoryChipKeys = [
  'tshirt',
  'jacket',
  'hoodie',
  'dress',
  'skirt',
  'sweater',
  'set',
  'abaya',
  'shorts',
  'pants',
];


int? subCategoryIdFor(String label) {
  final idx = kSubCategoryChipKeys.indexOf(label);
  return idx == -1 ? null : kSubCategories[idx].id;
}


int? sizeIdFor(int? parentCategoryId, String label) {
  if (parentCategoryId == null) return null;
  return kSizesByCategory[parentCategoryId]?[label];
}


List<String> sizeLabelsFor(int? parentCategoryId) {
  if (parentCategoryId == null) return const [];
  return kSizesByCategory[parentCategoryId]?.keys.toList() ?? const [];
}
