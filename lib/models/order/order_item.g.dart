// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map json) {
  return OrderItem(
    productId: json['productId'] as String,
    productQuantity: json['productQuantity'] as int,
    itemId: json['itemId'] as String,
    price: json['price'] as String,
    selectedColor: json['selectedColor'] as String,
    collectionId: json['collectionId'] as String,
    selectedSize: json['selectedSize'] as String,
    fabric: json['fabric'] as String,
    productCreator: json['productCreator'] == null
        ? null
        : Creator.fromJson(json['productCreator'] as Map),
    productImageUrl: json['productImageUrl'] as String,
    productTitle: json['productTitle'] as String,
    measurements: json['measurements'] as Map,
    currency: json['currency'] as String ?? 'USD',
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'productQuantity': instance.productQuantity,
      'itemId': instance.itemId,
      'price': instance.price,
      'selectedSize': instance.selectedSize,
      'selectedColor': instance.selectedColor,
      'fabric': instance.fabric,
      'collectionId': instance.collectionId,
      'productId': instance.productId,
      'productCreator': instance.productCreator,
      'productTitle': instance.productTitle,
      'productImageUrl': instance.productImageUrl,
      'currency': instance.currency,
      'measurements': instance.measurements,
    };
