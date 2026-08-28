// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterResponse _$FilterResponseFromJson(Map<String, dynamic> json) =>
    FilterResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PaginatedProducts.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterResponseToJson(FilterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

PaginatedProducts _$PaginatedProductsFromJson(Map<String, dynamic> json) =>
    PaginatedProducts(
      currentPage: (json['current_page'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ApiProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      from: (json['from'] as num?)?.toInt(),
      to: (json['to'] as num?)?.toInt(),
      nextPageUrl: json['next_page_url'] as String?,
      prevPageUrl: json['prev_page_url'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$PaginatedProductsToJson(PaginatedProducts instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'from': instance.from,
      'to': instance.to,
      'next_page_url': instance.nextPageUrl,
      'prev_page_url': instance.prevPageUrl,
      'path': instance.path,
    };

StoresListResponse _$StoresListResponseFromJson(Map<String, dynamic> json) =>
    StoresListResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => StoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoresListResponseToJson(StoresListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'stores': instance.stores?.map((e) => e.toJson()).toList(),
    };

SingleStoreResponse _$SingleStoreResponseFromJson(Map<String, dynamic> json) =>
    SingleStoreResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      store: json['store'] == null
          ? null
          : StoreModel.fromJson(json['store'] as Map<String, dynamic>),
      storeRating: doubleNullableCoerce(json['store_rating']),
    );

Map<String, dynamic> _$SingleStoreResponseToJson(
        SingleStoreResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'store': instance.store?.toJson(),
      'store_rating': instance.storeRating,
    };

SingleProductResponse _$SingleProductResponseFromJson(
        Map<String, dynamic> json) =>
    SingleProductResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      product: json['product'] == null
          ? null
          : ProductDetailModel.fromJson(
              json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleProductResponseToJson(
        SingleProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'product': instance.product?.toJson(),
    };

TopProductsResponse _$TopProductsResponseFromJson(Map<String, dynamic> json) =>
    TopProductsResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ApiProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopProductsResponseToJson(
        TopProductsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };

TopStoresResponse _$TopStoresResponseFromJson(Map<String, dynamic> json) =>
    TopStoresResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => StoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopStoresResponseToJson(TopStoresResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'stores': instance.stores?.map((e) => e.toJson()).toList(),
    };

FavoriteToggleResponse _$FavoriteToggleResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteToggleResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      isFavorite: boolCoerce(json['is_favorite']),
    );

Map<String, dynamic> _$FavoriteToggleResponseToJson(
        FavoriteToggleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'is_favorite': instance.isFavorite,
    };

FavoritesResponse _$FavoritesResponseFromJson(Map<String, dynamic> json) =>
    FavoritesResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => ApiProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoritesResponseToJson(FavoritesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'favorites': instance.favorites?.map((e) => e.toJson()).toList(),
    };

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ReportModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'store_id': instance.storeId,
      'product_id': instance.productId,
      'type': instance.type,
      'reason': instance.reason,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

CheckStoreResponse _$CheckStoreResponseFromJson(Map<String, dynamic> json) =>
    CheckStoreResponse(
      sameStore: boolCoerce(json['same_store']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CheckStoreResponseToJson(CheckStoreResponse instance) =>
    <String, dynamic>{
      'same_store': instance.sameStore,
      'message': instance.message,
    };

CartAddResponse _$CartAddResponseFromJson(Map<String, dynamic> json) =>
    CartAddResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
      cart: json['cart'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CartAddResponseToJson(CartAddResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'cart': instance.cart,
    };

ClearCartResponse _$ClearCartResponseFromJson(Map<String, dynamic> json) =>
    ClearCartResponse(
      status: _statusFromJson(json['status']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ClearCartResponseToJson(ClearCartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

AiSearchResponse _$AiSearchResponseFromJson(Map<String, dynamic> json) =>
    AiSearchResponse(
      filters: json['filters'] == null
          ? null
          : AiFiltersModel.fromJson(json['filters'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ApiProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AiSearchResponseToJson(AiSearchResponse instance) =>
    <String, dynamic>{
      'filters': instance.filters?.toJson(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };

AiFiltersModel _$AiFiltersModelFromJson(Map<String, dynamic> json) =>
    AiFiltersModel(
      category: json['category'] as String?,
      subCategories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sizes:
          (json['sizes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      color: json['color'] as String?,
      maxPrice: json['max_price'] as num?,
    );

Map<String, dynamic> _$AiFiltersModelToJson(AiFiltersModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'sub_categories': instance.subCategories,
      'sizes': instance.sizes,
      'color': instance.color,
      'max_price': instance.maxPrice,
    };
