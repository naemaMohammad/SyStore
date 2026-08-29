// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantAuthResponse _$MerchantAuthResponseFromJson(
  Map<String, dynamic> json,
) => MerchantAuthResponse(
  success: json['success'] as bool? ?? false,
  message: json['message'] as String?,
  token: json['token'] as String?,
  userData: json['user'] == null
      ? null
      : MerchantUserData.fromJson(json['user'] as Map<String, dynamic>),
  merchant: json['merchant'] as Map<String, dynamic>?,
  store: json['store'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MerchantAuthResponseToJson(
  MerchantAuthResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'token': instance.token,
  'user': instance.userData,
  'merchant': instance.merchant,
  'store': instance.store,
};

MerchantUserData _$MerchantUserDataFromJson(Map<String, dynamic> json) =>
    MerchantUserData(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      socialMedia: json['social_media'] as String?,
      idImage: json['id_image'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
    );

Map<String, dynamic> _$MerchantUserDataToJson(MerchantUserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'social_media': instance.socialMedia,
      'id_image': instance.idImage,
      'email_verified_at': instance.emailVerifiedAt,
    };
