// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num?)?.toInt(),
  storeId: json['storeId'],
  categoryId: json['category_id'],
  subCategoryId: json['sub_category_id'],
  name: json['name'] as String?,
  price: json['price'],
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  ratingCount: (json['ratingCount'] as num?)?.toInt(),
  soldCount: (json['soldCount'] as num?)?.toInt(),
  material: json['material'] as String?,
  image: json['image'] as String?,
  stateProduct: json['state_product'],
  deletedAt: json['deleted_at'],
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  productImages: json['images'] as List<dynamic>?,
  productVariants: json['variants'] as List<dynamic>?,
  colorsCount: (json['colors_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'storeId': instance.storeId,
  'category_id': instance.categoryId,
  'sub_category_id': instance.subCategoryId,
  'name': instance.name,
  'price': instance.price,
  'description': instance.description,
  'rating': instance.rating,
  'ratingCount': instance.ratingCount,
  'soldCount': instance.soldCount,
  'material': instance.material,
  'image': instance.image,
  'state_product': instance.stateProduct,
  'deleted_at': instance.deletedAt,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'images': instance.productImages,
  'variants': instance.productVariants,
  'colors_count': instance.colorsCount,
};

const _$ProductJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'storeId': {'type': 'object'},
    'category_id': {'type': 'object'},
    'sub_category_id': {'type': 'object'},
    'name': {'type': 'string'},
    'price': {'type': 'object'},
    'description': {'type': 'string'},
    'rating': {'type': 'integer'},
    'ratingCount': {'type': 'integer'},
    'soldCount': {'type': 'integer'},
    'material': {'type': 'string'},
    'image': {'type': 'string'},
    'state_product': {'type': 'object'},
    'deleted_at': {'type': 'object'},
    'created_at': {'type': 'string'},
    'updated_at': {'type': 'string'},
    'images': {
      'type': 'array',
      'items': {'type': 'object'},
    },
    'variants': {
      'type': 'array',
      'items': {'type': 'object'},
    },
    'colors_count': {'type': 'integer'},
  },
};
