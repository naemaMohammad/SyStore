// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreRequest _$StoreRequestFromJson(Map<String, dynamic> json) => StoreRequest(
  storeName: json['store_name'] as String,
  storePhone: json['store_phone'] as String,
  description: json['description'] as String,
  logoImage: json['logo_image'] as String?,
  coverImage: json['cover_image'] as String?,
  categoryIds: (json['category_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  deliveryZones: (json['delivery_zones'] as List<dynamic>)
      .map((e) => DeliveryZoneRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
  method: json['method'] as String? ?? 'put',
);

Map<String, dynamic> _$StoreRequestToJson(StoreRequest instance) =>
    <String, dynamic>{
      'store_name': instance.storeName,
      'store_phone': instance.storePhone,
      'description': instance.description,
      'logo_image': instance.logoImage,
      'cover_image': instance.coverImage,
      'category_ids': instance.categoryIds,
      'delivery_zones': instance.deliveryZones,
      'method': instance.method,
    };
