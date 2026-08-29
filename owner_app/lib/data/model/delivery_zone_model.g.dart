// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_zone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryZone _$DeliveryZoneFromJson(Map<String, dynamic> json) => DeliveryZone(
  id: (json['id'] as num).toInt(),
  sectorNameAr: json['sector_name_ar'] as String,
  sectorNameEn: json['sector_name_en'] as String,
  regions: json['regions'] as String?,
  regionsAr: json['regions_ar'] as String?,
  regionsEn: json['regions_en'] as String?,
);

Map<String, dynamic> _$DeliveryZoneToJson(DeliveryZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_name_ar': instance.sectorNameAr,
      'sector_name_en': instance.sectorNameEn,
      'regions': instance.regions,
      'regions_ar': instance.regionsAr,
      'regions_en': instance.regionsEn,
    };
