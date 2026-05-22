import 'package:flutter/material.dart';

class ProductVariant {
  Color? color;

  List<String> images;

  Map<String, int> stock;

  ProductVariant({
    this.color,
    this.images = const [],
    this.stock = const {},
  });
}