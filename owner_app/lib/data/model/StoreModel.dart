import 'package:json_annotation/json_annotation.dart';
import 'package:owner_app/data/model/ProductModel.dart';


part 'StoreModel.g.dart'; 

@JsonSerializable()
class StoreModel {
  String? message;
  Store? store;

  StoreModel({this.message, this.store});

  factory StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}

@JsonSerializable()
class Store {
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
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  
  
  List<Categories>? categories;
  @JsonKey(name: 'delivery_zones')
  List<DeliveryZones>? deliveryZones;
  
List<Product>? products;

  Store({
    this.id,
    this.merchantId,
    this.storeName,
    this.storePhone,
    this.logoImage,
    this.coverImage,
    this.location,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.deliveryZones,
    this.products,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class Categories {
  int? id;
  String? type;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  CategoryPivot? pivot;

  Categories({this.id, this.type, this.createdAt, this.updatedAt, this.pivot});

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class CategoryPivot {
  @JsonKey(name: 'store_id')
  int? storeId;
  @JsonKey(name: 'category_id')
  int? categoryId;

  CategoryPivot({this.storeId, this.categoryId});

  factory CategoryPivot.fromJson(Map<String, dynamic> json) => _$CategoryPivotFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryPivotToJson(this);
}

@JsonSerializable()
class DeliveryZones {
  int? id;
  @JsonKey(name: 'sector_name_ar')
  String? sectorNameAr;
  @JsonKey(name: 'sector_name_en')
  String? sectorNameEn;
  @JsonKey(name: 'regions_ar')
  String? regionsAr;
  @JsonKey(name: 'regions_en')
  String? regionsEn;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  DeliveryPivot? pivot;

  DeliveryZones({
    this.id,
    this.sectorNameAr,
    this.sectorNameEn,
    this.regionsAr,
    this.regionsEn,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory DeliveryZones.fromJson(Map<String, dynamic> json) => _$DeliveryZonesFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryZonesToJson(this);
}

@JsonSerializable()
class DeliveryPivot {
  @JsonKey(name: 'store_id')
  int? storeId;
  @JsonKey(name: 'delivery_zone_id')
  int? deliveryZoneId;
  String? price;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  DeliveryPivot({
    this.storeId,
    this.deliveryZoneId,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryPivot.fromJson(Map<String, dynamic> json) => _$DeliveryPivotFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryPivotToJson(this);
}