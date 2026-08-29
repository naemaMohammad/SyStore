// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

view_orders_model _$view_orders_modelFromJson(Map<String, dynamic> json) =>
    view_orders_model(
      message: json['message'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Orders.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$view_orders_modelToJson(view_orders_model instance) =>
    <String, dynamic>{'message': instance.message, 'orders': instance.orders};

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
  id: (json['id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  storeId: (json['store_id'] as num?)?.toInt(),
  deliveryZoneId: (json['delivery_zone_id'] as num?)?.toInt(),
  status: json['status'] as String?,
  address: json['address'] as String?,
  addressDetails: json['address_details'] as String?,
  customerPhone: json['customer_phone'] as String?,
  subTotal: json['sub_total'] as String?,
  totalPrice: json['total_price'] as String?,
  deliveryFee: json['delivery_fee'] as String?,
  rejectionReason: json['rejection_reason'],
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'store_id': instance.storeId,
  'delivery_zone_id': instance.deliveryZoneId,
  'status': instance.status,
  'address': instance.address,
  'address_details': instance.addressDetails,
  'customer_phone': instance.customerPhone,
  'sub_total': instance.subTotal,
  'total_price': instance.totalPrice,
  'delivery_fee': instance.deliveryFee,
  'rejection_reason': instance.rejectionReason,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'user': instance.user,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  fullName: json['full_name'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'] as String?,
  isBlocked: (json['is_blocked'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  fcmToken: json['fcm_token'],
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'phone': instance.phone,
  'email': instance.email,
  'email_verified_at': instance.emailVerifiedAt,
  'is_blocked': instance.isBlocked,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'fcm_token': instance.fcmToken,
};
