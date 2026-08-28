import 'package:json_annotation/json_annotation.dart';

part 'can_rate_model.g.dart';

@JsonSerializable()
class can_rate_model {
bool? status;
List<Data>? data;

 can_rate_model({
 this.status,
 this.data,
 });

factory can_rate_model.fromJson(Map<String, dynamic> json) =>
 _$can_rate_modelFromJson(json);

Map<String, dynamic> toJson() =>
_$can_rate_modelToJson(this);
}

@JsonSerializable()
class Data {
 int? id;

 @JsonKey(name: "user_id")
 int? userId;

 @JsonKey(name: "product_id")
 int? productId;

 String? rating;

 @JsonKey(name: "is_rated")
 int? isRated;

 @JsonKey(name: "created_at")
 String? createdAt;

 @JsonKey(name: "updated_at")
 String? updatedAt;

 Data({
 this.id,
 this.userId,
 this.productId,
 this.rating,
 this.isRated,
 this.createdAt,
 this.updatedAt,
 });

factory Data.fromJson(Map<String, dynamic> json) =>
 _$DataFromJson(json);

 Map<String, dynamic> toJson() =>
 _$DataToJson(this);
}