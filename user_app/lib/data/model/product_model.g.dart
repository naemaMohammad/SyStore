// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiProductModel _$ApiProductModelFromJson(Map<String, dynamic> json) =>
    ApiProductModel(
      id: (json['id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      subCategoryId: (json['sub_category_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: priceCoerce(json['price']),
      description: json['description'] as String?,
      material: json['material'] as String?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
      soldCount: (json['sold_count'] as num?)?.toInt(),
      stateProduct: boolCoerce(json['state_product']),
      store: json['store'] == null
          ? null
          : StoreModel.fromJson(json['store'] as Map<String, dynamic>),
      pivot: ApiProductModel._pivotFromJson(json['pivot']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$ApiProductModelToJson(ApiProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'category_id': instance.categoryId,
      'sub_category_id': instance.subCategoryId,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'material': instance.material,
      'image': instance.image,
      'rating': instance.rating,
      'rating_count': instance.ratingCount,
      'sold_count': instance.soldCount,
      'state_product': instance.stateProduct,
      'store': instance.store?.toJson(),
      'pivot': instance.pivot,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
