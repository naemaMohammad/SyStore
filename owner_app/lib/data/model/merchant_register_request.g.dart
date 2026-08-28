// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantRegisterRequest _$MerchantRegisterRequestFromJson(
  Map<String, dynamic> json,
) => MerchantRegisterRequest(
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String,
  socialMedia: json['social_media'] as String?,
  idImage: json['id_image'] as String?,
  storeName: json['store_name'] as String,
  storePhone: json['store_phone'] as String,
  location: json['location'] as String,
  description: json['description'] as String,
  logoImage: json['logo_image'] as String?,
  coverImage: json['cover_image'] as String?,
  categoryIds: (json['category_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  deliveryZones: (json['delivery_zones'] as List<dynamic>)
      .map((e) => DeliveryZoneRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MerchantRegisterRequestToJson(
  MerchantRegisterRequest instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'social_media': instance.socialMedia,
  'id_image': instance.idImage,
  'store_name': instance.storeName,
  'store_phone': instance.storePhone,
  'location': instance.location,
  'description': instance.description,
  'logo_image': instance.logoImage,
  'cover_image': instance.coverImage,
  'category_ids': instance.categoryIds,
  'delivery_zones': instance.deliveryZones,
};
