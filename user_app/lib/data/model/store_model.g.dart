// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      id: (json['id'] as num?)?.toInt(),
      merchantId: (json['merchant_id'] as num?)?.toInt(),
      storeName: json['store_name'] as String?,
      storePhone: json['store_phone'] as String?,
      logoImage: json['logo_image'] as String?,
      coverImage: json['cover_image'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      storeRating: doubleNullableCoerce(json['store_rating']),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ApiProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => StoreCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchant_id': instance.merchantId,
      'store_name': instance.storeName,
      'store_phone': instance.storePhone,
      'logo_image': instance.logoImage,
      'cover_image': instance.coverImage,
      'location': instance.location,
      'description': instance.description,
      'store_rating': instance.storeRating,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

StoreCategoryModel _$StoreCategoryModelFromJson(Map<String, dynamic> json) =>
    StoreCategoryModel(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      pivot: json['pivot'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StoreCategoryModelToJson(StoreCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'pivot': instance.pivot,
    };
