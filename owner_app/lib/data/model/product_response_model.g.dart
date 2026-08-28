// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
  Map<String, dynamic> json,
) => ProductResponseModel(
  status: json['status'] as bool?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProductResponseModelToJson(
  ProductResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'products': instance.products,
};
