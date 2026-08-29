// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

cart_update_model _$cart_update_modelFromJson(Map<String, dynamic> json) =>
    cart_update_model(
      message: json['message'] as String?,
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$cart_update_modelToJson(cart_update_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'product_variant_id': instance.productVariantId,
      'quantity': instance.quantity,
    };
