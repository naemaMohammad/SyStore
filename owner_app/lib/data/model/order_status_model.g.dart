// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

order_status_model _$order_status_modelFromJson(Map<String, dynamic> json) =>
    order_status_model(
      message: json['message'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$order_status_modelToJson(order_status_model instance) =>
    <String, dynamic>{'message': instance.message, 'status': instance.status};
