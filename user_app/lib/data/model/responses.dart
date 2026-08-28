import 'package:json_annotation/json_annotation.dart';
import 'package:user_app/data/model/product_model.dart';

import '../utils/api_utils.dart';
import 'product_detail_model.dart';
import 'store_model.dart';

part 'responses.g.dart';


@JsonSerializable(explicitToJson: true)
class FilterResponse {
  FilterResponse({this.status, this.message, this.data});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  PaginatedProducts? data;

  factory FilterResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaginatedProducts {
  PaginatedProducts({
    this.currentPage,
    this.data,
    this.lastPage,
    this.perPage,
    this.total,
    this.from,
    this.to,
    this.nextPageUrl,
    this.prevPageUrl,
    this.path,
  });

  @JsonKey(name: 'current_page')
  int? currentPage;

  List<ApiProductModel>? data;

  @JsonKey(name: 'last_page')
  int? lastPage;

  @JsonKey(name: 'per_page')
  int? perPage;

  int? total;
  int? from;
  int? to;

  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;

  @JsonKey(name: 'prev_page_url')
  String? prevPageUrl;

  String? path;

  factory PaginatedProducts.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProductsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedProductsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StoresListResponse {
  StoresListResponse({this.status, this.message, this.stores});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  List<StoreModel>? stores;

  factory StoresListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoresListResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class SingleStoreResponse {
  SingleStoreResponse({
    this.status,
    this.message,
    this.store,
    this.storeRating,
  });

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  StoreModel? store;

  @JsonKey(name: 'store_rating', fromJson: doubleNullableCoerce)
  double? storeRating;

  factory SingleStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleStoreResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class SingleProductResponse {
  SingleProductResponse({this.status, this.message, this.product});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  ProductDetailModel? product;

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleProductResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class TopProductsResponse {
  TopProductsResponse({this.status, this.message, this.products});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  List<ApiProductModel>? products;

  factory TopProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$TopProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopProductsResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class TopStoresResponse {
  TopStoresResponse({this.status, this.message, this.stores});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  List<StoreModel>? stores;

  factory TopStoresResponse.fromJson(Map<String, dynamic> json) =>
      _$TopStoresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopStoresResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class FavoriteToggleResponse {
  FavoriteToggleResponse({
    this.status,
    this.message,
    this.isFavorite,
  });

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  @JsonKey(name: 'is_favorite', fromJson: boolCoerce)
  bool? isFavorite;

  factory FavoriteToggleResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteToggleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToggleResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class FavoritesResponse {
  FavoritesResponse({this.status, this.message, this.favorites});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  List<ApiProductModel>? favorites;

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class ReportResponse {
  ReportResponse({this.status, this.message, this.data});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  ReportModel? data;

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReportModel {
  ReportModel({
    this.id,
    this.userId,
    this.storeId,
    this.productId,
    this.type,
    this.reason,
    this.createdAt,
    this.updatedAt,
  });

  int? id;

  @JsonKey(name: 'user_id')
  int? userId;

  @JsonKey(name: 'store_id')
  int? storeId;

  @JsonKey(name: 'product_id')
  int? productId;

  String? type;
  String? reason;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}


@JsonSerializable(explicitToJson: true)
class CheckStoreResponse {
  CheckStoreResponse({this.sameStore, this.message});

  @JsonKey(name: 'same_store', fromJson: boolCoerce)
  bool? sameStore;

  String? message;

  factory CheckStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckStoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckStoreResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartAddResponse {
  CartAddResponse({this.status, this.message, this.cart});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  Map<String, dynamic>? cart;

  factory CartAddResponse.fromJson(Map<String, dynamic> json) =>
      _$CartAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartAddResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ClearCartResponse {
  ClearCartResponse({this.status, this.message});

  @JsonKey(fromJson: _statusFromJson)
  bool? status;

  String? message;

  factory ClearCartResponse.fromJson(Map<String, dynamic> json) =>
      _$ClearCartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ClearCartResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class AiSearchResponse {
  AiSearchResponse({this.filters, this.products});

  AiFiltersModel? filters;

  List<ApiProductModel>? products;

  factory AiSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AiSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AiSearchResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AiFiltersModel {
  AiFiltersModel({
    this.category,
    this.subCategories,
    this.sizes,
    this.color,
    this.maxPrice,
  });

  String? category;

  @JsonKey(name: 'sub_categories')
  List<String>? subCategories;

  List<String>? sizes;

  String? color;

  @JsonKey(name: 'max_price')
  num? maxPrice;

  factory AiFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$AiFiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AiFiltersModelToJson(this);
}


bool? _statusFromJson(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  return v.toString() == 'true' || v.toString() == '1';
}
