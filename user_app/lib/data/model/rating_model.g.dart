// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

rating_model _$rating_modelFromJson(Map<String, dynamic> json) => rating_model(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      productRating: (json['product_rating'] as num?)?.toInt(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$rating_modelToJson(rating_model instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'product_rating': instance.productRating,
      'rating_count': instance.ratingCount,
    };
