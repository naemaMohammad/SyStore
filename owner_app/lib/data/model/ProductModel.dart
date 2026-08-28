import 'package:json_annotation/json_annotation.dart';
part 'ProductModel.g.dart';

class ProductModel {
  bool? status;
  String? message;
  Product? product;

  ProductModel({this.status, this.message, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
@JsonSerializable(createJsonSchema: true)
class Product {
  int? id;
  dynamic storeId;
 @JsonKey(name: 'category_id')
 dynamic categoryId;
  @JsonKey(name: 'sub_category_id')
  dynamic subCategoryId;
  String? name;
  dynamic price;
  String? description;
  int? rating;
  int? ratingCount;
  int? soldCount;
  String? material;
  String? image;
  @JsonKey(name: 'state_product')
  dynamic stateProduct;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;

  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
@JsonKey(name: 'images')
  List<dynamic>? productImages;

  @JsonKey(name: 'variants')
  List<dynamic>? productVariants;

  @JsonKey(name: 'colors_count')
  int? colorsCount;

  Product({
    this.id,
    this.storeId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.price,
    this.description,
    this.rating,
    this.ratingCount,
    this.soldCount,
    this.material,
    this.image,
    this.stateProduct,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productImages,
    this.productVariants,
    this.colorsCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final product = _$ProductFromJson(json);

  
    product.productVariants ??= _asList(json['product_variants']);
    product.productImages ??= _asList(json['product_images']);

    // ايجاد عدد الوان يدويا
    product.colorsCount ??= (json['colors_count'] as num?)?.toInt();

    return product;
  }


  static List<dynamic>? _asList(dynamic value) {
    if (value == null) return null;
    if (value is List) return value;
    if (value is Map) {
      for (final key in const ['data', 'items', 'list']) {
        if (value[key] is List) return value[key] as List<dynamic>;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final json = _$ProductToJson(this);
  
    return json;
  }


  
}