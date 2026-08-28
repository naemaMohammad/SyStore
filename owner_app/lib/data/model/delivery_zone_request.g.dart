// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_zone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryZoneRequest _$DeliveryZoneRequestFromJson(Map<String, dynamic> json) =>
    DeliveryZoneRequest(
      deliveryZoneId: (json['delivery_zone_id'] as num).toInt(),
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$DeliveryZoneRequestToJson(
  DeliveryZoneRequest instance,
) => <String, dynamic>{
  'delivery_zone_id': instance.deliveryZoneId,
  'price': instance.price,
};
