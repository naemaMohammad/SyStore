import 'package:json_annotation/json_annotation.dart';

part 'all_stores_reviews_model.g.dart';

@JsonSerializable()
class all_stores_reviews_model {
  bool? status;
  List<Reviews>? reviews;

  all_stores_reviews_model({this.status, this.reviews});

  factory all_stores_reviews_model.fromJson(Map<String, dynamic> json) => _$all_stores_reviews_modelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$all_stores_reviews_modelToJson(this);
}


@JsonSerializable()
class Reviews {
  String? image;
  @JsonKey(name: "order_id")
  int? orderId;
  @JsonKey(name: "user_name")
  String? userName;
  @JsonKey(name: "user_phone")
  String? userPhone;
  String? rating;

  Reviews(
      {this.image, this.orderId, this.userName, this.userPhone, this.rating});

  factory Reviews.fromJson(Map<String, dynamic> json) => _$ReviewsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}