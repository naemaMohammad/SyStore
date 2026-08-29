import 'package:json_annotation/json_annotation.dart';

part 'add_cart_model.g.dart';

@JsonSerializable()
// ignore: camel_case_types
class add_cart_model {
  String? message;
  Cart? cart;

  add_cart_model({this.message, this.cart});

  factory add_cart_model.fromJson(Map<String, dynamic> json) => _$add_cart_modelFromJson(json);
  Map<String, dynamic> toJson() => _$add_cart_modelToJson(this);
}
@JsonSerializable()
class Cart {
  int? id;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<Variants>? variants;

  Cart({this.id, this.userId, this.createdAt, this.updatedAt, this.variants});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class Variants {
  int? id;
  int? productId;
  int? colorId;
  int? sizeId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  Product? product;
  Color? color;
  Size? size;

  Variants(
      {this.id,
      this.productId,
      this.colorId,
      this.sizeId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.product,
      this.color,
      this.size});

  factory Variants.fromJson(Map<String, dynamic> json) => _$VariantsFromJson(json);
  Map<String, dynamic> toJson() => _$VariantsToJson(this);
}

@JsonSerializable()
class Pivot {
  int? cartId;
  int? productVariantId;
  String? price;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.cartId,
      this.productVariantId,
      this.price,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);
  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

@JsonSerializable()
class Product {
  int? id;
  int? storeId;
  int? categoryId;
  int? subCategoryId;
  String? name;
  String? price;
  String? description;
  int? rating;
  int? ratingCount;
  int? soldCount;
  String? material;
  String? image;
  int? stateProduct;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.storeId,
      this.categoryId,
      this.subCategoryId,
      this.name,
      this.price,
      this.description,
      this.rating,
      this.ratingCount,
      this.soldCount,
      this.material,
      this.image,
      this.stateProduct,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Color {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Color({this.id, this.name, this.createdAt, this.updatedAt});

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
  Map<String, dynamic> toJson() => _$ColorToJson(this);
}

@JsonSerializable()
class Size {
  int? id;
  String? name;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  Size({this.id, this.name, this.categoryId, this.createdAt, this.updatedAt});

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
  Map<String, dynamic> toJson() => _$SizeToJson(this);
}