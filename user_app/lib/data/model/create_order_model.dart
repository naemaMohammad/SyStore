import 'package:json_annotation/json_annotation.dart';

part 'create_order_model.g.dart';

@JsonSerializable()
class create_order_model {
  String? message;
  Order? order;

  create_order_model({this.message, this.order});

  factory create_order_model.fromJson(Map<String, dynamic> json) => _$create_order_modelFromJson(json);
  Map<String, dynamic> toJson() => _$create_order_modelToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "store_id")
  int? storeId;
  @JsonKey(name: "delivery_zone_id")
  int? deliveryZoneId;
  String? address;
  @JsonKey(name: "address_details")
  String? addressDetails;
  @JsonKey(name: "customer_phone")
  String? customerPhone;
  @JsonKey(name: "sub_total")
  String? subTotal;
  @JsonKey(name: "delivery_fee")
  String? deliveryFee;
  @JsonKey(name: "total_price")
  String? totalPrice;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  int? id;

  Order(
      {this.userId,
      this.storeId,
      this.deliveryZoneId,
      this.address,
      this.addressDetails,
      this.customerPhone,
      this.subTotal,
      this.deliveryFee,
      this.totalPrice,
      this.updatedAt,
      this.createdAt,
      this.id});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}