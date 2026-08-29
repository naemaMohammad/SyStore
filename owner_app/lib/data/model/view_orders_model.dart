import 'package:json_annotation/json_annotation.dart';

part 'view_orders_model.g.dart';

@JsonSerializable()
class view_orders_model {
  String? message;
  List<Orders>? orders;

  view_orders_model({this.message, this.orders});

  factory view_orders_model.fromJson(Map<String, dynamic> json) => _$view_orders_modelFromJson(json);
  Map<String, dynamic> toJson() => _$view_orders_modelToJson(this);
}
@JsonSerializable()
class Orders {
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
  User? user;

  Orders(
      {this.id,
      @JsonKey(name: "user_id")
      this.userId,
      @JsonKey(name: "store_id")
      this.storeId,
      @JsonKey(name: "delivery_zone_id")
      this.deliveryZoneId,
      this.status,
      this.address,
      @JsonKey(name: "address_details")
      this.addressDetails,
      @JsonKey(name: "customer_phone")
      this.customerPhone,
      @JsonKey(name: "sub_total")
      this.subTotal,
      @JsonKey(name: "total_price")
      this.totalPrice,
      @JsonKey(name: "delivery_fee")
      this.deliveryFee,
      @JsonKey(name: "rejection_reason")
      this.rejectionReason,
      @JsonKey(name: "created_at")
      this.createdAt,
      @JsonKey(name: "updated_at")
      this.updatedAt,
      this.user});

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersToJson(this);
}
@JsonSerializable()
class User {
  int? id;
  @JsonKey(name: "full_name")
  String? fullName;
  String? phone;
  String? email;
  @JsonKey(name: "email_verified_at")
  String? emailVerifiedAt;
  @JsonKey(name: "is_blocked")
  int? isBlocked;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "fcm_token")
  dynamic fcmToken;

  User(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.fcmToken});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}