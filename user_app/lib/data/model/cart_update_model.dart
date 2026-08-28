import 'package:json_annotation/json_annotation.dart';

part 'cart_update_model.g.dart';

@JsonSerializable()
class cart_update_model {
  String? message;
  @JsonKey(name: "product_variant_id")
  int? productVariantId;
  int? quantity;

  cart_update_model({this.message, this.productVariantId, this.quantity});

  factory cart_update_model.fromJson(Map<String, dynamic> json) => _$cart_update_modelFromJson(json);
  Map<String, dynamic> toJson() => _$cart_update_modelToJson(this);
}