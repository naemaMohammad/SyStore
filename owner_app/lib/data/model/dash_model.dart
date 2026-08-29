
import 'package:json_annotation/json_annotation.dart';

part 'dash_model.g.dart';

@JsonSerializable()
class dash_model {
  String? message;
  Data? data;

  dash_model({this.message, this.data});

factory dash_model.fromJson(Map<String, dynamic> json) => _$dash_modelFromJson(json);
  Map<String, dynamic> toJson() => _$dash_modelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "total_sales")
  String? totalSales;

  @JsonKey(name: "new_orders")
  int? newOrders;

  @JsonKey(name: "total_orders")
  int? totalOrders;

  @JsonKey(name: "on_the_way_orders")
  int? onTheWayOrders;

  @JsonKey(name: "reviews_count")
  int? reviewsCount;

  @JsonKey(name: "total_sold_products")
  String? totalSoldProducts;

  Data({
    this.totalSales,
    this.newOrders,
    this.totalOrders,
    this.onTheWayOrders,
    this.reviewsCount,
    this.totalSoldProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataToJson(this);
}