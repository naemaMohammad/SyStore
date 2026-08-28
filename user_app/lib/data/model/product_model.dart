import 'package:json_annotation/json_annotation.dart';

import '../utils/api_utils.dart';
import 'store_model.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiProductModel {
  ApiProductModel({
    this.id,
    this.storeId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.price,
    this.description,
    this.material,
    this.image,
    this.rating,
    this.ratingCount,
    this.soldCount,
    this.stateProduct,
    this.store,
    this.pivot,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;

  @JsonKey(name: 'store_id')
  int? storeId;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'sub_category_id')
  int? subCategoryId;

  String? name;

  @JsonKey(fromJson: priceCoerce)
  double? price;

  String? description;
  String? material;

  String? image;

  int? rating;

  @JsonKey(name: 'rating_count')
  int? ratingCount;

  @JsonKey(name: 'sold_count')
  int? soldCount;

  @JsonKey(name: 'state_product', fromJson: boolCoerce)
  bool? stateProduct;

  StoreModel? store;

  @JsonKey(fromJson: _pivotFromJson)
  Map<String, dynamic>? pivot;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  String get url => imageUrl(image);

  double get priceValue => price ?? 0;

  int get ratingValue => rating ?? 0;

 
  bool get isAvailable => stateProduct ?? true;

  factory ApiProductModel.fromJson(Map<String, dynamic> json) =>
      _$ApiProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiProductModelToJson(this);

  static Map<String, dynamic>? _pivotFromJson(dynamic v) =>
      v is Map<String, dynamic> ? v : null;
}
