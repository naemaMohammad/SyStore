import 'package:json_annotation/json_annotation.dart';

part 'cart_clear_model.g.dart';

@JsonSerializable()
class cart_clear_model {
  String? message;

  cart_clear_model({this.message});

  factory cart_clear_model.fromJson(Map<String, dynamic> json) => _$cart_clear_modelFromJson(json);

  Map<String, dynamic> toJson() => _$cart_clear_modelToJson(this);
}