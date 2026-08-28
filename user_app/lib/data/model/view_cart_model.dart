import 'package:json_annotation/json_annotation.dart';

part 'view_cart_model.g.dart';

@JsonSerializable()
class view_cart_model {
  String? message;
  @JsonKey(name: "sub_total")
  int? subTotal;
  @JsonKey(name: "delivery_fee")
  int? deliveryFee;
  @JsonKey(name: "total_price")
  int? totalPrice;
  Cart? cart;

  view_cart_model(
      {this.message,
      this.subTotal,
      this.deliveryFee,
      this.totalPrice,
      this.cart});

  factory view_cart_model.fromJson(Map<String, dynamic> json) => _$view_cart_modelFromJson(json);
  Map<String, dynamic> toJson() => _$view_cart_modelToJson(this);
}
@JsonSerializable()
class Cart {
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  List<Variants>? variants;

  Cart({this.id, this.userId, this.createdAt, this.updatedAt, this.variants});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
@JsonSerializable()
class Variants {
  int? id;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "color_id")
  int? colorId;
  @JsonKey(name: "size_id")
  int? sizeId;
  int? quantity;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
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
  @JsonKey(name: "cart_id")
  int? cartId;
  @JsonKey(name: "product_Variant_id")
  int? productVariantId;
  String? price;
  int? quantity;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
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
  @JsonKey(name: "store_id")
  int? storeId;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "sub_category_id")
  int? subCategoryId;
  String? name;
  String? price;
  String? description;
  int? rating;
  @JsonKey(name: "rating_count")
  int? ratingCount;
  @JsonKey(name: "sold_count")
  int? soldCount;
  String? material;
  String? image;
  @JsonKey(name: "state_product")
  int? stateProduct;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
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
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Color({this.id, this.name, this.createdAt, this.updatedAt});

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);
  Map<String, dynamic> toJson() => _$ColorToJson(this);
}
@JsonSerializable()
class Size {
  int? id;
  String? name;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Size({this.id, this.name, this.categoryId, this.createdAt, this.updatedAt});

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
  Map<String, dynamic> toJson() => _$SizeToJson(this);
}