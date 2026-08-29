// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

view_cart_model _$view_cart_modelFromJson(Map<String, dynamic> json) =>
    view_cart_model(
      message: json['message'] as String?,
      subTotal: (json['sub_total'] as num?)?.toInt(),
      deliveryFee: (json['delivery_fee'] as num?)?.toInt(),
      totalPrice: (json['total_price'] as num?)?.toInt(),
      cart: json['cart'] == null
          ? null
          : Cart.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$view_cart_modelToJson(view_cart_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sub_total': instance.subTotal,
      'delivery_fee': instance.deliveryFee,
      'total_price': instance.totalPrice,
      'cart': instance.cart,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'variants': instance.variants,
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
      cartId: (json['cart_id'] as num?)?.toInt(),
      productVariantId: (json['product_Variant_id'] as num?)?.toInt(),
      price: json['price'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'cart_id': instance.cartId,
      'product_Variant_id': instance.productVariantId,
      'price': instance.price,
      'quantity': instance.quantity,
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
