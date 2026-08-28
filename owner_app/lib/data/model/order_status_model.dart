
import 'package:json_annotation/json_annotation.dart';

part 'order_status_model.g.dart';

@JsonSerializable()
class order_status_model {
  String? message;
  String? status;

  order_status_model({this.message, this.status});

  factory order_status_model.fromJson(Map<String, dynamic> json) => _$order_status_modelFromJson(json);
  Map<String, dynamic> toJson() => _$order_status_modelToJson(this);
}