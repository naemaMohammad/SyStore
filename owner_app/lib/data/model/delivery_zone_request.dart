// lib/app/data/models/merchant/delivery_zone_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'delivery_zone_request.g.dart';

@JsonSerializable()
class DeliveryZoneRequest {
  @JsonKey(name: 'delivery_zone_id')
  final int deliveryZoneId;
  
  final int price;

  DeliveryZoneRequest({
    required this.deliveryZoneId,
    required this.price,
  });

  factory DeliveryZoneRequest.fromJson(Map<String, dynamic> json) =>
      _$DeliveryZoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryZoneRequestToJson(this);
}