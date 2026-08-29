import 'package:json_annotation/json_annotation.dart';

part 'show_order_model.g.dart';

@JsonSerializable()
class show_order_model {
  String? message;
  Order? order;

  show_order_model({this.message, this.order});

  factory show_order_model.fromJson(Map<String, dynamic> json) => _$show_order_modelFromJson(json);
  Map<String, dynamic> toJson() => _$show_order_modelToJson(this);
}
@JsonSerializable()
class Order {
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "store_id")
  int? storeId;
  @JsonKey(name: "delivery_zone_id")
  int? deliveryZoneId;
  String? status;
  String? address;
  @JsonKey(name: "address_details")
  String? addressDetails;
  @JsonKey(name: "customer_phone")
  String? customerPhone;
  @JsonKey(name: "sub_total")
  String? subTotal;
  @JsonKey(name: "total_price")
  String? totalPrice;
  @JsonKey(name: "delivery_fee")
  String? deliveryFee;
  @JsonKey(name: "rejection_reason")
  dynamic rejectionReason;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  Store? store;
  @JsonKey(name: "delivery_zone")
  DeliveryZone? deliveryZone;
  List<Variants>? variants;

  Order(
      {this.id,
      this.userId,
      this.storeId,
      this.deliveryZoneId,
      this.status,
      this.address,
      this.addressDetails,
      this.customerPhone,
      this.subTotal,
      this.totalPrice,
      this.deliveryFee,
      this.rejectionReason,
      this.createdAt,
      this.updatedAt,
      this.store,
      this.deliveryZone,
      this.variants});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
@JsonSerializable()
class Store {
  int? id;
  @JsonKey(name: "merchant_id")
  int? merchantId;
  @JsonKey(name: "store_name")
  String? storeName;
  @JsonKey(name: "store_phone")
  String? storePhone;
  @JsonKey(name: "logo_image")
  String? logoImage;
  @JsonKey(name: "cover_image")
  String? coverImage;
  String? location;
  String? description;
  @JsonKey(name: "deleted_at")
  dynamic deletedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Store(
      {this.id,
      this.merchantId,
      this.storeName,
      this.storePhone,
      this.logoImage,
      this.coverImage,
      this.location,
      this.description,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
@JsonSerializable()
class DeliveryZone {
  int? id;
  @JsonKey(name: "sector_name_ar")
  String? sectorNameAr;
  @JsonKey(name: "sector_name_en")
  String? sectorNameEn;
  @JsonKey(name: "regions_ar")
  String? regionsAr;
  @JsonKey(name: "regions_en")
  String? regionsEn;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  DeliveryZone(
      {this.id,
      this.sectorNameAr,
      this.sectorNameEn,
      this.regionsAr,
      this.regionsEn,
      this.createdAt,
      this.updatedAt});

  factory DeliveryZone.fromJson(Map<String, dynamic> json) => _$DeliveryZoneFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);
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
  @JsonKey(name: "order_id")
  int? orderId;
  @JsonKey(name: "product_variant_id")
  int? productVariantId;
  int? quantity;
  String? price;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Pivot(
      {this.orderId,
      this.productVariantId,
      this.quantity,
      this.price,
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