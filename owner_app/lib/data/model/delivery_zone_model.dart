// lib/app/data/models/merchant/delivery_zone_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'delivery_zone_model.g.dart';

@JsonSerializable()
class DeliveryZone {
  final int id;
  
  @JsonKey(name: 'sector_name_ar')
  final String sectorNameAr;
  
  @JsonKey(name: 'sector_name_en')
  final String sectorNameEn;
  
  final String? regions;
  
  @JsonKey(name: 'regions_ar')
  final String? regionsAr;
  
  @JsonKey(name: 'regions_en')
  final String? regionsEn;

  DeliveryZone({
    required this.id,
    required this.sectorNameAr,
    required this.sectorNameEn,
    this.regions,
    this.regionsAr,
    this.regionsEn,
  });

  factory DeliveryZone.fromJson(Map<String, dynamic> json) =>
      _$DeliveryZoneFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);
}