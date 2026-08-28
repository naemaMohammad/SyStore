import 'package:json_annotation/json_annotation.dart';
import 'package:owner_app/data/model/ProductModel.dart';


part 'product_response_model.g.dart'; 

@JsonSerializable()
class ProductResponseModel {
  bool? status;
  List<Product>? products;

  ProductResponseModel({this.status, this.products});

  
  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    final model = _$ProductResponseModelFromJson(json);

 
    model.products ??= _extractProducts(json);

    return model;
  }

 
  static List<Product>? _extractProducts(Map<String, dynamic> json) {
    final dataField = json['data'];
    if (dataField is Map<String, dynamic>) {
      final nested = dataField['data'];
      if (nested is List && nested.isNotEmpty) {
        return nested
            .map((e) => e is Map<String, dynamic>
                ? Product.fromJson(e)
                : Product.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }

  
    for (final key in const ['products', 'data', 'items']) {
      final value = json[key];
      if (value is List && value.isNotEmpty) {
        return value
            .map((e) => e is Map<String, dynamic>
                ? Product.fromJson(e)
                : Product.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}