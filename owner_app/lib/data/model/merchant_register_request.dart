// lib/app/data/models/merchant/merchant_register_request.dart
import 'package:json_annotation/json_annotation.dart';
import 'delivery_zone_request.dart';  // ✅ استيراد

part 'merchant_register_request.g.dart';

@JsonSerializable()
class MerchantRegisterRequest {
  @JsonKey(name: 'full_name')
  final String fullName;
  
  final String email;
  final String phone;
  final String password;
  
  @JsonKey(name: 'social_media')
  final String? socialMedia;
  
  @JsonKey(name: 'id_image')
  final String? idImage;
  
  @JsonKey(name: 'store_name')
  final String storeName;
  
  @JsonKey(name: 'store_phone')
  final String storePhone;
  
  final String location;
  final String description;
  
  @JsonKey(name: 'logo_image')
  final String? logoImage;
  
  @JsonKey(name: 'cover_image')
  final String? coverImage;
  
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;
  
  @JsonKey(name: 'delivery_zones')
  final List<DeliveryZoneRequest> deliveryZones;  // ✅ استخدام الكلاس المنفصل

  MerchantRegisterRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.socialMedia,
    this.idImage,
    required this.storeName,
    required this.storePhone,
    required this.location,
    required this.description,
    this.logoImage,
    this.coverImage,
    required this.categoryIds,
    required this.deliveryZones,
  });

  factory MerchantRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$MerchantRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantRegisterRequestToJson(this);
}