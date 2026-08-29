// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sliders_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlidersResponseModel _$SlidersResponseModelFromJson(
        Map<String, dynamic> json) =>
    SlidersResponseModel(
      message: json['message'] as String,
      sliders: (json['sliders'] as List<dynamic>)
          .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlidersResponseModelToJson(
        SlidersResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sliders': instance.sliders,
    };
