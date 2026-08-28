// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: priceCoerce(json['price']),
      description: json['description'] as String?,
      material: json['material'] as String?,
      averageRating: doubleNullableCoerce(json['average_rating']),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map(
              (e) => ProductVariantRowModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'material': instance.material,
      'average_rating': instance.averageRating,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'variants': instance.variants?.map((e) => e.toJson()).toList(),
    };

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      image: json['image'] as String?,
      colorId: (json['color_id'] as num?)?.toInt(),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'color_id': instance.colorId,
      'color': instance.color,
    };

ProductVariantRowModel _$ProductVariantRowModelFromJson(
        Map<String, dynamic> json) =>
    ProductVariantRowModel(
      id: (json['id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      colorId: (json['color_id'] as num?)?.toInt(),
      color: json['color'] as String?,
      sizeId: (json['size_id'] as num?)?.toInt(),
      size: json['size'] as String?,
    );

Map<String, dynamic> _$ProductVariantRowModelToJson(
        ProductVariantRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_variant_id': instance.productVariantId,
      'quantity': instance.quantity,
      'color_id': instance.colorId,
      'color': instance.color,
      'size_id': instance.sizeId,
      'size': instance.size,
    };
