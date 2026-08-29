import 'package:json_annotation/json_annotation.dart';

part 'order_cancelled_model.g.dart';

@JsonSerializable()
class order_cancelled_model {
  String? message;

  order_cancelled_model({this.message});

  factory order_cancelled_model.fromJson(Map<String, dynamic> json) => _$order_cancelled_modelFromJson(json);
  Map<String, dynamic> toJson() => _$order_cancelled_modelToJson(this);
}
