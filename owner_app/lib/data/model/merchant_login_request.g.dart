// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantLoginRequest _$MerchantLoginRequestFromJson(
  Map<String, dynamic> json,
) => MerchantLoginRequest(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$MerchantLoginRequestToJson(
  MerchantLoginRequest instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password};
