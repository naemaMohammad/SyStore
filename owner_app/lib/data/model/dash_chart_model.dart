import 'package:json_annotation/json_annotation.dart';

part 'dash_chart_model.g.dart';

@JsonSerializable()
class dash_chart_model {
  String? message;
  List<Data>? data;

  dash_chart_model({this.message, this.data});

 factory dash_chart_model.fromJson(Map<String, dynamic> json) => _$dash_chart_modelFromJson(json);
  Map<String, dynamic> toJson() => _$dash_chart_modelToJson(this);
}

@JsonSerializable()
class Data {
  String? day;
  int? orders;

  Data({this.day, this.orders});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}