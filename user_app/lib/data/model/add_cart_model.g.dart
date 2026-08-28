// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

add_cart_model _$add_cart_modelFromJson(Map<String, dynamic> json) =>
    add_cart_model(
      message: json['message'] as String?,
      cart: json['cart'] == null
          ? null
          : Cart.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$add_cart_modelToJson(add_cart_model instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart': instance.cart,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'variants': instance.variants,
    };

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      colorId: (json['colorId'] as num?)?.toInt(),
      sizeId: (json['sizeId'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
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
      'productId': instance.productId,
      'colorId': instance.colorId,
      'sizeId': instance.sizeId,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'pivot': instance.pivot,
      'product': instance.product,
      'color': instance.color,
      'size': instance.size,
    };

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      cartId: (json['cartId'] as num?)?.toInt(),
      productVariantId: (json['productVariantId'] as num?)?.toInt(),
      price: json['price'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'productVariantId': instance.productVariantId,
      'price': instance.price,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      storeId: (json['storeId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
      subCategoryId: (json['subCategoryId'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      ratingCount: (json['ratingCount'] as num?)?.toInt(),
      soldCount: (json['soldCount'] as num?)?.toInt(),
      material: json['material'] as String?,
      image: json['image'] as String?,
      stateProduct: (json['stateProduct'] as num?)?.toInt(),
      deletedAt: json['deletedAt'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'rating': instance.rating,
      'ratingCount': instance.ratingCount,
      'soldCount': instance.soldCount,
      'material': instance.material,
      'image': instance.image,
      'stateProduct': instance.stateProduct,
      'deletedAt': instance.deletedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
