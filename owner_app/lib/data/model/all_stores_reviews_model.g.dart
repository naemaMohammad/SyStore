// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_stores_reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

all_stores_reviews_model _$all_stores_reviews_modelFromJson(
  Map<String, dynamic> json,
) => all_stores_reviews_model(
  status: json['status'] as bool?,
  reviews: (json['reviews'] as List<dynamic>?)
      ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$all_stores_reviews_modelToJson(
  all_stores_reviews_model instance,
) => <String, dynamic>{'status': instance.status, 'reviews': instance.reviews};

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
  image: json['image'] as String?,
  orderId: (json['order_id'] as num?)?.toInt(),
  userName: json['user_name'] as String?,
  userPhone: json['user_phone'] as String?,
  rating: json['rating'] as String?,
);

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
  'image': instance.image,
  'order_id': instance.orderId,
  'user_name': instance.userName,
  'user_phone': instance.userPhone,
  'rating': instance.rating,
};
