// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

show_order_model _$show_order_modelFromJson(Map<String, dynamic> json) =>
    show_order_model(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$show_order_modelToJson(show_order_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      deliveryZoneId: (json['delivery_zone_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      address: json['address'] as String?,
      addressDetails: json['address_details'] as String?,
      customerPhone: json['customer_phone'] as String?,
      subTotal: json['sub_total'] as String?,
      totalPrice: json['total_price'] as String?,
      deliveryFee: json['delivery_fee'] as String?,
      rejectionReason: json['rejection_reason'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      store: json['store'] == null
          ? null
          : Store.fromJson(json['store'] as Map<String, dynamic>),
      deliveryZone: json['delivery_zone'] == null
          ? null
          : DeliveryZone.fromJson(
              json['delivery_zone'] as Map<String, dynamic>),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'store_id': instance.storeId,
      'delivery_zone_id': instance.deliveryZoneId,
      'status': instance.status,
      'address': instance.address,
      'address_details': instance.addressDetails,
      'customer_phone': instance.customerPhone,
      'sub_total': instance.subTotal,
      'total_price': instance.totalPrice,
      'delivery_fee': instance.deliveryFee,
      'rejection_reason': instance.rejectionReason,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'store': instance.store,
      'delivery_zone': instance.deliveryZone,
      'variants': instance.variants,
    };

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: (json['id'] as num?)?.toInt(),
      merchantId: (json['merchant_id'] as num?)?.toInt(),
      storeName: json['store_name'] as String?,
      storePhone: json['store_phone'] as String?,
      logoImage: json['logo_image'] as String?,
      coverImage: json['cover_image'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'merchant_id': instance.merchantId,
      'store_name': instance.storeName,
      'store_phone': instance.storePhone,
      'logo_image': instance.logoImage,
      'cover_image': instance.coverImage,
      'location': instance.location,
      'description': instance.description,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

DeliveryZone _$DeliveryZoneFromJson(Map<String, dynamic> json) => DeliveryZone(
      id: (json['id'] as num?)?.toInt(),
      sectorNameAr: json['sector_name_ar'] as String?,
      sectorNameEn: json['sector_name_en'] as String?,
      regionsAr: json['regions_ar'] as String?,
      regionsEn: json['regions_en'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DeliveryZoneToJson(DeliveryZone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sector_name_ar': instance.sectorNameAr,
      'sector_name_en': instance.sectorNameEn,
      'regions_ar': instance.regionsAr,
      'regions_en': instance.regionsEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      colorId: (json['color_id'] as num?)?.toInt(),
      sizeId: (json['size_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      color: json['color'] == null
          ? null
          : Color.fromJson(json['color'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : Size.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'color_id': instance.colorId,
      'size_id': instance.sizeId,
      'quantity': instance.quantity,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
      'product': instance.product,
      'color': instance.color,
      'size': instance.size,
    };

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      orderId: (json['order_id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      price: json['price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'product_variant_id': instance.productVariantId,
      'quantity': instance.quantity,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      storeId: (json['store_id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      subCategoryId: (json['sub_category_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      ratingCount: (json['rating_count'] as num?)?.toInt(),
      soldCount: (json['sold_count'] as num?)?.toInt(),
      material: json['material'] as String?,
      image: json['image'] as String?,
      stateProduct: (json['state_product'] as num?)?.toInt(),
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'category_id': instance.categoryId,
      'sub_category_id': instance.subCategoryId,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'rating': instance.rating,
      'rating_count': instance.ratingCount,
      'sold_count': instance.soldCount,
      'material': instance.material,
      'image': instance.image,
      'state_product': instance.stateProduct,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_id': instance.categoryId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
