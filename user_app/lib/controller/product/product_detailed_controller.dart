import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/product_detail_model.dart';
import '../../data/services/api_client.dart';


class ProductDetailsController extends GetxController {
  final Rx<ProductDetailModel?> product = Rx<ProductDetailModel?>(null);

  final RxBool isLoading = false.obs;

  final Rx<int?> selectedColorId = Rx<int?>(null);

  final Rx<int?> selectedSizeId = Rx<int?>(null);

  final RxInt quantity = 1.obs;

  ApiClient get _api => Get.find<ApiClient>();
Future<void> loadProduct(int id) async {
  isLoading.value = true;
  try {
    final res = await _api.getProduct(id);
    bind(res.product);
  } on Exception catch (_) {
    Get.snackbar(
      'Error',
      'Could not load product details.',
      snackPosition: SnackPosition.BOTTOM,
    );
  } finally {
    isLoading.value = false;
  }
}
  void clear() {
    product.value = null;
    selectedColorId.value = null;
    selectedSizeId.value = null;
    quantity.value = 1;
  }

  void bind(ProductDetailModel? p) {
    product.value = p;
    selectedColorId.value = null;
    selectedSizeId.value = null;
    quantity.value = 1;
  }


  List<({int colorId, String color, Color swatch})> get availableColors {
    final seen = <int>{};
    final out = <({int colorId, String color, Color swatch})>[];

    void addColor(int? id, String? name) {
      if (id == null || !seen.add(id)) return;
      final n = name ?? '';
      out.add((colorId: id, color: n, swatch: colorFromName(n)));
    }

    for (final v in product.value?.variants ?? const <ProductVariantRowModel>[]) {
      addColor(v.colorId, v.color);
    }
    return out;
  }

  List<({int sizeId, String size})> get availableSizes {
    final seen = <int>{};
    final out = <({int sizeId, String size})>[];
    for (final v in product.value?.variants ?? const <ProductVariantRowModel>[]) {
      final id = v.sizeId;
      if (id != null && seen.add(id)) {
        out.add((sizeId: id, size: v.size ?? ''));
      }
    }
    return out;
  }

  ProductVariantRowModel? get selectedVariant {
    final cId = selectedColorId.value;
    final sId = selectedSizeId.value;
    if (cId == null || sId == null) return null;
    final variants = product.value?.variants;
    if (variants == null || variants.isEmpty) return null;
    for (final v in variants) {
      if (v.colorId == cId && v.sizeId == sId) return v;
    }
    return null;
  }

  
  int? get selectedVariantId => selectedVariant?.productVariantIdValue;


  bool get selectionComplete =>
      selectedColorId.value != null && selectedSizeId.value != null;

  int? get selectedVariantStock => selectedVariant?.quantity;

  bool get isOutOfStock {
    final variant = selectedVariant;
    if (variant == null) return false; 
    final qty = variant.quantity;
    return qty == null || qty <= 0;
  }

  
  bool get canAddToCart {
    final variant = selectedVariant;
    if (variant == null) return false;
    final qty = variant.quantity;
    return qty != null && qty > 0;
  }

  bool get isComboUnavailable {
    if (!selectionComplete) return false;
    final variant = selectedVariant;
    return variant == null || (variant.quantity ?? 0) <= 0;
  }

  void selectColor(int colorId) {
    selectedColorId.value = colorId;
    _reclampQuantity();
    _notifyOutOfStock();
  }

  void selectSize(int sizeId) {
    selectedSizeId.value = sizeId;
    _reclampQuantity();
    _notifyOutOfStock();
  }


  void increaseQuantity() {
    if (isOutOfStock) {
      Get.snackbar(
        'Out of Stock',
        'This specific color and size is currently out of stock.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final max = selectedVariantStock;
    if (max == null) return;
    if (quantity.value >= max) {
      Get.snackbar(
        'Maximum Limit',
        'You have reached the maximum available quantity for this item.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  void _reclampQuantity() {
    final max = selectedVariantStock;
    if (max == null) {
      quantity.value = 1;
      return;
    }
    if (quantity.value > max) quantity.value = max;
    if (quantity.value < 1) quantity.value = 1;
  }

  void _notifyOutOfStock() {
    if (isOutOfStock) {
      Get.snackbar(
        'Out of Stock',
        'This specific color and size is currently out of stock.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}


Color colorFromName(String? name) {
  if (name == null || name.isEmpty) return const Color(0xFFBDBDBD);

  final raw = name.trim();
  final hex = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$')
      .firstMatch(raw);
  if (hex != null) {
    var h = hex.group(1)!;
    if (h.length == 3) {
      h = h.split('').map((c) => '$c$c').join();
    }
    final full = h.padRight(8, 'f');
    final value = int.parse(full, radix: 16);
    return Color(value);
  }

  final lowered = raw.toLowerCase();
  final tokens = lowered.split(RegExp(r'[\s/_-]+'))..removeWhere((t) => t.isEmpty);

  Color? match(String? key) =>
      key == null ? null : _namedColors[key];

  final fullMatch = match(_namedColors.containsKey(lowered) ? lowered : null);
  if (fullMatch != null) return fullMatch;
  for (final t in tokens) {
    final c = match(t);
    if (c != null) return c;
  }


  return _hashColor(lowered);
}


Color _hashColor(String s) {
  var hash = 0;
  for (final code in s.codeUnits) {
    hash = (hash * 31 + code) & 0x7FFFFFFF;
  }
  final hue = hash % 360;
  return HSLColor.fromAHSL(1.0, hue.toDouble(), 0.55, 0.55).toColor();
}


const Map<String, Color> _namedColors = {
  
  'black': Color(0xFF000000),
  'white': Color(0xFFFFFFFF),
  'red': Color(0xFFF44336),
  'green': Color(0xFF4CAF50),
  'blue': Color(0xFF2196F3),
  'yellow': Color(0xFFFFEB3B),
  'orange': Color(0xFFFF9800),
  'purple': Color(0xFF9C27B0),
  'pink': Color(0xFFE91E63),
  'brown': Color(0xFF795548),
  'grey': Color(0xFF9E9E9E),
  'gray': Color(0xFF9E9E9E),
  'cyan': Color(0xFF00BCD4),
  'teal': Color(0xFF009688),
  'lime': Color(0xFFCDDC39),
  'magenta': Color(0xFFFF00FF),
  'maroon': Color(0xFF800000),
  'olive': Color(0xFF808000),
  'navy': Color(0xFF1A237E),
  'gold': Color(0xFFFFD700),
  'silver': Color(0xFFC0C0C0),
  'beige': Color(0xFFF5F5DC),
  'ivory': Color(0xFFFFFFF0),
  'khaki': Color(0xFFF0E68C),
  'tan': Color(0xFFD2B48C),
  'coral': Color(0xFFFF7F50),
  'salmon': Color(0xFFFA8072),
  'turquoise': Color(0xFF40E0D0),
  'violet': Color(0xFF9400D3),
  'indigo': Color(0xFF3F51B5),
  'lavender': Color(0xFFE6E6FA),
  'peach': Color(0xFFFFCBA4),
  'mint': Color(0xFF98FF98),
  'rose': Color(0xFFFF007F),
  'wine': Color(0xFF722F37),
  'burgundy': Color(0xFF800020),
  'charcoal': Color(0xFF36454F),
  'crimson': Color(0xFFDC143C),
  'emerald': Color(0xFF50C878),
  'fuchsia': Color(0xFFFF00FF),
  'mustard': Color(0xFFFFDB58),
  'ruby': Color(0xFFE0115F),
  'sapphire': Color(0xFF0F52BA),

  'navy blue': Color(0xFF1A237E),
  'baby blue': Color(0xFF89CFF0),
  'sky blue': Color(0xFF87CEEB),
  'royal blue': Color(0xFF4169E1),
  'light blue': Color(0xFFB3E5FC),
  'dark blue': Color(0xFF0D47A1),
  'powder blue': Color(0xFFB0E0E6),
  'steel blue': Color(0xFF4682B4),
  'midnight blue': Color(0xFF191970),
  'denim blue': Color(0xFF1560BD),
  'light green': Color(0xFFB2DFDB),
  'dark green': Color(0xFF1B5E20),
  'mint green': Color(0xFF98FF98),
  'olive green': Color(0xFF808000),
  'forest green': Color(0xFF228B22),
  'light pink': Color(0xFFFFB6C1),
  'dark pink': Color(0xFFE91E63),
  'hot pink': Color(0xFFFF69B4),
  'baby pink': Color(0xFFFFB6C1),
  'rose pink': Color(0xFFFF66CC),
  'light grey': Color(0xFFE0E0E0),
  'light gray': Color(0xFFE0E0E0),
  'dark grey': Color(0xFF424242),
  'dark gray': Color(0xFF424242),
  'light red': Color(0xFFFFCDD2),
  'dark red': Color(0xFF8B0000),
  'light purple': Color(0xFFE1BEE7),
  'dark purple': Color(0xFF4A148C),
  'light yellow': Color(0xFFFFF9C4),
  'light orange': Color(0xFFFFE0B2),
  'dark orange': Color(0xFFE65100),
  'light brown': Color(0xFFBCAAA4),
  'dark brown': Color(0xFF3E2723),
  'off white': Color(0xFFFAF9F6),
  'cream': Color(0xFFFFFDD0),
  'skin': Color(0xFFE0AC69),
  'nude': Color(0xFFF2D6BD),

  'baby': Color(0xFF89CFF0),
  'light': Color(0xFFB3E5FC),
  'dark': Color(0xFF1C1C1C),
  'sky': Color(0xFF87CEEB),
  'royal': Color(0xFF4169E1),
  'powder': Color(0xFFB0E0E6),
  'steel': Color(0xFF4682B4),
  'midnight': Color(0xFF191970),
  'denim': Color(0xFF1560BD),
  'aqua': Color(0xFF00FFFF),
  'azure': Color(0xFF007FFF),
  'flesh': Color(0xFFFFCBA4),
  'forest': Color(0xFF228B22),
  'hot': Color(0xFFFF69B4),
  'off': Color(0xFFFAF9F6),
};
