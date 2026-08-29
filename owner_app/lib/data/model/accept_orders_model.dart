import 'package:json_annotation/json_annotation.dart';

part 'accept_orders_model.g.dart';

@JsonSerializable()
class accept_orders_model {
  String? message;

  accept_orders_model({this.message});

  factory accept_orders_model.fromJson(Map<String, dynamic> json) => _$accept_orders_modelFromJson(json);

  Map<String, dynamic> toJson() => _$accept_orders_modelToJson(this);
}