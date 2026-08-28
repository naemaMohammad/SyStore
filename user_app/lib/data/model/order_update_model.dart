import 'package:json_annotation/json_annotation.dart';

part 'order_update_model.g.dart';

@JsonSerializable()
class order_update_model {
  String? message;
  Order? order;

  order_update_model({this.message, this.order});

  factory order_update_model.fromJson(Map<String, dynamic> json) => _$order_update_modelFromJson(json);
  Map<String, dynamic> toJson() => _$order_update_modelToJson(this);
}
@JsonSerializable()
class Order {
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "store_id")
  int? storeId;
  @JsonKey(name: "delivery_zone_id")
  int? deliveryZoneId;
  String? status;
  String? address;
  @JsonKey(name: "address_details")
  String? addressDetails;
  @JsonKey(name: "customer_phone")
  String? customerPhone;
  @JsonKey(name: "sub_total")
  String? subTotal;
  @JsonKey(name: "total_price")
  String? totalPrice;
  @JsonKey(name: "delivery_fee")
  String? deliveryFee;
  @JsonKey(name: "rejection_reason")
  dynamic rejectionReason;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "delivery_zone")
  DeliveryZone? deliveryZone;

  Order(
      {this.id,
      this.userId,
      this.storeId,
      this.deliveryZoneId,
      this.status,
      this.address,
      this.addressDetails,
      this.customerPhone,
      this.subTotal,
      this.totalPrice,
      this.deliveryFee,
      this.rejectionReason,
      this.createdAt,
      this.updatedAt,
      this.deliveryZone});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
@JsonSerializable()
class DeliveryZone {
  int? id;
  @JsonKey(name: "sector_name_ar")
  String? sectorNameAr;
  @JsonKey(name: "sector_name_en")
  String? sectorNameEn;
  @JsonKey(name: "regions_ar")
  String? regionsAr;
  @JsonKey(name: "regions_en")
  String? regionsEn;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  DeliveryZone(
      {this.id,
      this.sectorNameAr,
      this.sectorNameEn,
      this.regionsAr,
      this.regionsEn,
      this.createdAt,
      this.updatedAt});

  factory DeliveryZone.fromJson(Map<String, dynamic> json) => _$DeliveryZoneFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);
}