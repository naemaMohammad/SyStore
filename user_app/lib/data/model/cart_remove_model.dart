import 'package:json_annotation/json_annotation.dart';

part 'cart_remove_model.g.dart';

@JsonSerializable()
class cart_remove_model {
  String? message;

  cart_remove_model({this.message});

  factory cart_remove_model.fromJson(Map<String, dynamic> json) => _$cart_remove_modelFromJson(json);
  Map<String, dynamic> toJson() => _$cart_remove_modelToJson(this);
}