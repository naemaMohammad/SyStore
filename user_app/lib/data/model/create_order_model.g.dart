// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

create_order_model _$create_order_modelFromJson(Map<String, dynamic> json) =>
    create_order_model(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$create_order_modelToJson(create_order_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      userId: (json['user_id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      deliveryZoneId: (json['delivery_zone_id'] as num?)?.toInt(),
      address: json['address'] as String?,
      addressDetails: json['address_details'] as String?,
      customerPhone: json['customer_phone'] as String?,
      subTotal: json['sub_total'] as String?,
      deliveryFee: json['delivery_fee'] as String?,
      totalPrice: json['total_price'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user_id': instance.userId,
      'store_id': instance.storeId,
      'delivery_zone_id': instance.deliveryZoneId,
      'address': instance.address,
      'address_details': instance.addressDetails,
      'customer_phone': instance.customerPhone,
      'sub_total': instance.subTotal,
      'delivery_fee': instance.deliveryFee,
      'total_price': instance.totalPrice,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
