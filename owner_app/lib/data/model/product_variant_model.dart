import 'package:flutter/material.dart';

class ProductVariant {
  Color? color;

  List<String> images;
int? colorId;
  Map<String, int> stock;

  ProductVariant({
    this.colorId,
    this.color,
    this.images = const [],
    this.stock = const {},
  });
}