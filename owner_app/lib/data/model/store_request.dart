// lib/app/data/models/merchant/store_request.dart
import 'package:json_annotation/json_annotation.dart';
import 'delivery_zone_request.dart';  // ✅ استيراد

part 'store_request.g.dart';

@JsonSerializable()
class StoreRequest {
  @JsonKey(name: 'store_name')
  final String storeName;
  
  @JsonKey(name: 'store_phone')
  final String storePhone;
  
  final String description;
  
  @JsonKey(name: 'logo_image')
  final String? logoImage;
  
  @JsonKey(name: 'cover_image')
  final String? coverImage;
  
  @JsonKey(name: 'category_ids')
  final List<int> categoryIds;
  
  @JsonKey(name: 'delivery_zones')
  final List<DeliveryZoneRequest> deliveryZones;  // ✅ استخدام الكلاس المنفصل
  
  final String method;

  StoreRequest({
    required this.storeName,
    required this.storePhone,
    required this.description,
    this.logoImage,
    this.coverImage,
    required this.categoryIds,
    required this.deliveryZones,
    this.method = 'put',
  });

  factory StoreRequest.fromJson(Map<String, dynamic> json) =>
      _$StoreRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StoreRequestToJson(this);
}