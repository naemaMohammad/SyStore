// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StoreModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
  message: json['message'] as String?,
  store: json['store'] == null
      ? null
      : Store.fromJson(json['store'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{'message': instance.message, 'store': instance.store};

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
  id: (json['id'] as num?)?.toInt(),
  merchantId: (json['merchant_id'] as num?)?.toInt(),
  storeName: json['store_name'] as String?,
  storePhone: json['store_phone'] as String?,
  logoImage: json['logo_image'] as String?,
  coverImage: json['cover_image'] as String?,
  location: json['location'] as String?,
  description: json['description'] as String?,
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveryZones: (json['delivery_zones'] as List<dynamic>?)
      ?.map((e) => DeliveryZones.fromJson(e as Map<String, dynamic>))
      .toList(),
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'id': instance.id,
  'merchant_id': instance.merchantId,
  'store_name': instance.storeName,
  'store_phone': instance.storePhone,
  'logo_image': instance.logoImage,
  'cover_image': instance.coverImage,
  'location': instance.location,
  'description': instance.description,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'categories': instance.categories,
  'delivery_zones': instance.deliveryZones,
  'products': instance.products,
};

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  pivot: json['pivot'] == null
      ? null
      : CategoryPivot.fromJson(json['pivot'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };

CategoryPivot _$CategoryPivotFromJson(Map<String, dynamic> json) =>
    CategoryPivot(
      storeId: (json['store_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryPivotToJson(CategoryPivot instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'category_id': instance.categoryId,
    };

DeliveryZones _$DeliveryZonesFromJson(Map<String, dynamic> json) =>
    DeliveryZones(
      id: (json['id'] as num?)?.toInt(),
      sectorNameAr: json['sector_name_ar'] as String?,
      sectorNameEn: json['sector_name_en'] as String?,
      regionsAr: json['regions_ar'] as String?,
      regionsEn: json['regions_en'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : DeliveryPivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeliveryZonesToJson(DeliveryZones instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_name_ar': instance.sectorNameAr,
      'sector_name_en': instance.sectorNameEn,
      'regions_ar': instance.regionsAr,
      'regions_en': instance.regionsEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };

DeliveryPivot _$DeliveryPivotFromJson(Map<String, dynamic> json) =>
    DeliveryPivot(
      storeId: (json['store_id'] as num?)?.toInt(),
      deliveryZoneId: (json['delivery_zone_id'] as num?)?.toInt(),
      price: json['price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DeliveryPivotToJson(DeliveryPivot instance) =>
    <String, dynamic>{
      'store_id': instance.storeId,
      'delivery_zone_id': instance.deliveryZoneId,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
