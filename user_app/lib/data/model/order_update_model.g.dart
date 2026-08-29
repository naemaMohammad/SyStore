// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

order_update_model _$order_update_modelFromJson(Map<String, dynamic> json) =>
    order_update_model(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$order_update_modelToJson(order_update_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
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
      deliveryZone: json['delivery_zone'] == null
          ? null
          : DeliveryZone.fromJson(
              json['delivery_zone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
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
      'delivery_zone': instance.deliveryZone,
    };

DeliveryZone _$DeliveryZoneFromJson(Map<String, dynamic> json) => DeliveryZone(
      id: (json['id'] as num?)?.toInt(),
      sectorNameAr: json['sector_name_ar'] as String?,
      sectorNameEn: json['sector_name_en'] as String?,
      regionsAr: json['regions_ar'] as String?,
      regionsEn: json['regions_en'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DeliveryZoneToJson(DeliveryZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_name_ar': instance.sectorNameAr,
      'sector_name_en': instance.sectorNameEn,
      'regions_ar': instance.regionsAr,
      'regions_en': instance.regionsEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
