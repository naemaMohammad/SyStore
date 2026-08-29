import 'package:json_annotation/json_annotation.dart';
import 'package:user_app/data/model/product_model.dart';

import '../utils/api_utils.dart';

part 'store_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreModel {
  StoreModel({
    this.id,
    this.merchantId,
    this.storeName,
    this.storePhone,
    this.logoImage,
    this.coverImage,
    this.location,
    this.description,
    this.storeRating,
    this.products,
    this.categories,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;

  @JsonKey(name: 'merchant_id')
  int? merchantId;

  @JsonKey(name: 'store_name')
  String? storeName;

  @JsonKey(name: 'store_phone')
  String? storePhone;

  @JsonKey(name: 'logo_image')
  String? logoImage;

  @JsonKey(name: 'cover_image')
  String? coverImage;

  String? location;
  String? description;


  @JsonKey(name: 'store_rating', fromJson: doubleNullableCoerce)
  double? storeRating;

  List<ApiProductModel>? products;

 
  List<StoreCategoryModel>? categories;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  String get logoUrl => imageUrl(logoImage);

  String get coverUrl => imageUrl(coverImage);

  
  double get ratingValue => storeRating ?? 0.0;

  List<String> get categoryTypes =>
      categories?.map((c) => (c.type ?? '').toLowerCase()).toList() ??
      const [];

 
  bool hasCategory(String name) {
    final needle = _normalizeCategory(name);
    if (needle.isEmpty) return false;
    return categoryTypes.any((t) => t == needle || _singularOf(t) == needle);
  }

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}


@JsonSerializable(explicitToJson: true)
class StoreCategoryModel {
  StoreCategoryModel({this.id, this.type, this.pivot});

  int? id;

  String? type;

  Map<String, dynamic>? pivot;

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoreCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCategoryModelToJson(this);
}


String _normalizeCategory(String name) {
  var n = name.trim().toLowerCase();
  if (n.endsWith('s') && n.length > 1) {
    n = n.substring(0, n.length - 1);
  }
  return n;
}

String _singularOf(String type) => _normalizeCategory(type);

