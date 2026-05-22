import 'package:owner_app/data/model/product_variant_model.dart';


class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final List<String> sizes;
  List<ProductVariant> variants;
  final String storeId;
  bool isActive;
  double rating; 
  final String material;
  final String productType;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.sizes,
    required this.variants,
    required this.storeId,
    this.isActive =true,
    this.rating = 4.5,
   required this.material, 
   required this.productType,
  });
}
