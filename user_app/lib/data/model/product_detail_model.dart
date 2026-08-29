import 'package:json_annotation/json_annotation.dart';

import '../utils/api_utils.dart';

part 'product_detail_model.g.dart';


@JsonSerializable(explicitToJson: true)
class ProductDetailModel {
  ProductDetailModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.material,
    this.averageRating,
    this.images,
    this.variants,
  });

  int? id;
  String? name;

  @JsonKey(fromJson: priceCoerce)
  double? price;

  String? description;
  String? material;

  @JsonKey(name: 'average_rating', fromJson: doubleNullableCoerce)
  double? averageRating;

  List<ProductImageModel>? images;

  List<ProductVariantRowModel>? variants;

  double get averageRatingValue => averageRating ?? 0;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductImageModel {
  ProductImageModel({this.image, this.colorId, this.color});

  String? image;

  @JsonKey(name: 'color_id')
  int? colorId;

  String? color;

  String get url => imageUrl(image);

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductVariantRowModel {
  ProductVariantRowModel({
    this.id,
    this.productVariantId,
    this.quantity,
    this.colorId,
    this.color,
    this.sizeId,
    this.size,
  });

 
  int? id;


  @JsonKey(name: 'product_variant_id')
  int? productVariantId;

 
  int? get productVariantIdValue => productVariantId ?? id;

  int? quantity;

  @JsonKey(name: 'color_id')
  int? colorId;

  String? color;

  @JsonKey(name: 'size_id')
  int? sizeId;

  String? size;

  factory ProductVariantRowModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantRowModelToJson(this);
}
