// lib/app/data/models/merchant/merchant_auth_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'merchant_auth_response.g.dart';

@JsonSerializable()
class MerchantAuthResponse {
  @JsonKey(defaultValue: false)
  final bool success;
  
  final String? message;
  final String? token;
  
  @JsonKey(name: 'user')
  final MerchantUserData? userData;
  
  // ✅ أضف merchant و store
  @JsonKey(name: 'merchant')
  final Map<String, dynamic>? merchant;
  
  @JsonKey(name: 'store')
  final Map<String, dynamic>? store;

  MerchantAuthResponse({
    required this.success,
    this.message,
    this.token,
    this.userData,
    this.merchant,
    this.store,
  });

  factory MerchantAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$MerchantAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantAuthResponseToJson(this);
}

@JsonSerializable()
class MerchantUserData {
  final int? id;
  
  @JsonKey(name: 'full_name')
  final String? fullName;
  
  final String? email;
  final String? phone;
  
  @JsonKey(name: 'social_media')
  final String? socialMedia;
  
  @JsonKey(name: 'id_image')
  final String? idImage;
  
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;

  MerchantUserData({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.socialMedia,
    this.idImage,
    this.emailVerifiedAt,
  });

  factory MerchantUserData.fromJson(Map<String, dynamic> json) =>
      _$MerchantUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantUserDataToJson(this);
}