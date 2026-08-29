import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class rating_model {
  bool? status;
  String? message;
  @JsonKey(name: "product_rating")
  int? productRating;
  @JsonKey(name: "rating_count")
  int? ratingCount;

  rating_model(
      {this.status, this.message, this.productRating, this.ratingCount});

  factory rating_model.fromJson(Map<String, dynamic> json) => _$rating_modelFromJson(json);
  Map<String, dynamic> toJson() => _$rating_modelToJson(this);
}