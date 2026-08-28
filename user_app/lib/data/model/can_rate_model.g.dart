// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'can_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

can_rate_model _$can_rate_modelFromJson(Map<String, dynamic> json) =>
    can_rate_model(
      status: json['status'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$can_rate_modelToJson(can_rate_model instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      rating: json['rating'] as String?,
      isRated: (json['is_rated'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'product_id': instance.productId,
      'rating': instance.rating,
      'is_rated': instance.isRated,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
