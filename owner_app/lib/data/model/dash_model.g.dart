// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

dash_model _$dash_modelFromJson(Map<String, dynamic> json) => dash_model(
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$dash_modelToJson(dash_model instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  totalSales: json['total_sales'] as String?,
  newOrders: (json['new_orders'] as num?)?.toInt(),
  totalOrders: (json['total_orders'] as num?)?.toInt(),
  onTheWayOrders: (json['on_the_way_orders'] as num?)?.toInt(),
  reviewsCount: (json['reviews_count'] as num?)?.toInt(),
  totalSoldProducts: json['total_sold_products'] as String?,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'total_sales': instance.totalSales,
  'new_orders': instance.newOrders,
  'total_orders': instance.totalOrders,
  'on_the_way_orders': instance.onTheWayOrders,
  'reviews_count': instance.reviewsCount,
  'total_sold_products': instance.totalSoldProducts,
};
