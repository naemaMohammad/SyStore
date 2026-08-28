import 'package:json_annotation/json_annotation.dart';
import 'slider_model.dart';

part 'sliders_response_model.g.dart';

@JsonSerializable()
class SlidersResponseModel {
  final String message;
  final List<SliderModel> sliders;

  SlidersResponseModel({
    required this.message,
    required this.sliders,
  });

  factory SlidersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SlidersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SlidersResponseModelToJson(this);
}