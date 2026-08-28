import 'package:flutter/material.dart';
import 'package:owner_app/data/model/Colors_Model.dart';

/// Client-side catalog constants for the `GET /products/filter` endpoint.
///
/// The backend stores `categories`, `sub_categories`, `sizes`, and `colors` as
/// integer-ID lookup tables, but exposes no catalog endpoint to the client. The
/// `sub_categories` table has **no foreign key** to `categories`, and the
/// `colors` table stores only `id` + `name` (no hex) — so the Flutter app must
/// keep its own authoritative maps. This file is that single source of truth.
///
/// Spec source: ColorSeeder.php / SizeSeeder.php / SubCategorySeeder.php
/// (screenshots 861–869).
///
/// NOTE: `category_id` is **not** an accepted filter parameter (the backend
/// ignores it). These category IDs are used only to disambiguate `size_id`
/// (sizes are globally unique per parent category) and to label the UI.

/// A category: men / women / boys / girls (ids 1–4).
class CategoryEntry {
  final int id;
  final String name;
  const CategoryEntry({required this.id, required this.name});
}

/// A sub-category (ids 1–10). Sub-categories are shared across all parent
/// categories — the backend's `sub_categories` table has no FK to
/// `categories`, and the product team confirmed no client-side parent→child
/// enforcement is wanted.
class SubCategoryEntry {
  final int id;
  final String name;
  const SubCategoryEntry({required this.id, required this.name});
}

/// Parent categories (id → name).
const List<CategoryEntry> kCategories = [
  CategoryEntry(id: 1, name: 'men'),
  CategoryEntry(id: 2, name: 'women'),
  CategoryEntry(id: 3, name: 'boys'),
  CategoryEntry(id: 4, name: 'girls'),
];

/// Sub-categories (id → name). All 10 are shared by every parent category.
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

/// Sizes keyed by parent category id → size label → globally-unique `size_id`.
///
/// The backend's `size_id` is unique across the whole table (1–24), so the
/// label "S" maps to size_id 1 for men OR 7 for women. A parent category must
/// be selected before a size can be resolved.
const Map<int, Map<String, int>> kSizesByCategory = {
  1: {'S': 1, 'M': 2, 'L': 3, 'XL': 4, 'XXL': 5, 'Free': 6}, // men
  2: {'S': 7, 'M': 8, 'L': 9, 'XL': 10, 'XXL': 11, 'Free': 12}, // women
  3: {'8Y': 13, '10Y': 14, '12Y': 15, '14Y': 16, '16Y': 17, 'Free': 18}, // boys
  4: {'8Y': 19, '10Y': 20, '12Y': 21, '14Y': 22, '16Y': 23, 'Free': 24}, // girls
};

/// Colors (id → name → hex). The hex is client-side only; the backend stores
/// only `id` + `name`. Reuses the existing [AppColorModel].
final List<AppColorModel> kColors = [
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

/// The shared localized chip key for a sub-category (matches the `.tr` keys
/// used in the filter UI). Order matches [kSubCategories].
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

/// Resolves a sub-category's integer id from its localized chip label.
/// Returns `null` if the label is not a known sub-category.
int? subCategoryIdFor(String label) {
  final idx = kSubCategoryChipKeys.indexOf(label);
  return idx == -1 ? null : kSubCategories[idx].id;
}

/// Resolves a size's integer id from its label and the selected parent
/// category. Returns `null` if no parent is selected or the label is unknown
/// for that parent.
int? sizeIdFor(int? parentCategoryId, String label) {
  if (parentCategoryId == null) return null;
  return kSizesByCategory[parentCategoryId]?[label];
}

/// The size chip labels for a given parent category (in display order), or
/// an empty list if no parent is selected.
List<String> sizeLabelsFor(int? parentCategoryId) {
  if (parentCategoryId == null) return const [];
  return kSizesByCategory[parentCategoryId]?.keys.toList() ?? const [];
}
