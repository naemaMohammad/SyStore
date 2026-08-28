// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_delivery_zones_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

cart_delivery_zones_model _$cart_delivery_zones_modelFromJson(
        Map<String, dynamic> json) =>
    cart_delivery_zones_model(
      message: json['message'] as String?,
      deliveryZones: (json['delivery_zones'] as List<dynamic>?)
          ?.map((e) => DeliveryZones.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$cart_delivery_zones_modelToJson(
        cart_delivery_zones_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'delivery_zones': instance.deliveryZones,
    };

DeliveryZones _$DeliveryZonesFromJson(Map<String, dynamic> json) =>
    DeliveryZones(
      id: (json['id'] as num?)?.toInt(),
      sectorNameAr: json['sector_name_ar'] as String?,
      sectorNameEn: json['sector_name_en'] as String?,
      regionsAr: json['regions_ar'] as String?,
      regionsEn: json['regions_en'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeliveryZonesToJson(DeliveryZones instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_name_ar': instance.sectorNameAr,
      'sector_name_en': instance.sectorNameEn,
      'regions_ar': instance.regionsAr,
      'regions_en': instance.regionsEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      storeId: (json['store_id'] as num?)?.toInt(),
      deliveryZoneId: (json['delivery_zone_id'] as num?)?.toInt(),
      price: json['price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'store_id': instance.storeId,
      'delivery_zone_id': instance.deliveryZoneId,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
