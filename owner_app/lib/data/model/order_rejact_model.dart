import 'package:json_annotation/json_annotation.dart';

part 'order_rejact_model.g.dart';

@JsonSerializable()
class order_rejact_model {
  String? message;

  order_rejact_model({this.message});

  factory order_rejact_model.fromJson(Map<String, dynamic> json) => _$order_rejact_modelFromJson(json);
  Map<String, dynamic> toJson() => _$order_rejact_modelToJson(this);
}
