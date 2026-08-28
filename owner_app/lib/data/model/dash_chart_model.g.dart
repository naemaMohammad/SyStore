// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

dash_chart_model _$dash_chart_modelFromJson(Map<String, dynamic> json) =>
    dash_chart_model(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$dash_chart_modelToJson(dash_chart_model instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  day: json['day'] as String?,
  orders: (json['orders'] as num?)?.toInt(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'day': instance.day,
  'orders': instance.orders,
};
