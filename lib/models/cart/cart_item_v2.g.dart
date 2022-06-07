// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemV2 _$CartItemV2FromJson(Map json) {
  return CartItemV2(
    productId: json['productId'] as String,
    productQuantity: json['productQuantity'] as int,
    price: json['price'] as String,
    selectedColor: json['selectedColor'] as String,
    collectionId: json['collectionId'] as String,
    selectedSize: json['selectedSize'] as String,
    productImageUrl: json['productImageUrl'] as String,
    itemId: json['itemId'] as String,
    fabric: json['fabric'] as String,
    currency: json['currency'] as String,
    productCreator: json['productCreator'] == null
        ? null
        : Creator.fromJson(json['productCreator'] as Map),
    productTitle: json['productTitle'] as String,
    measurements: json['measurements'] as Map,
  );
}

Map<String, dynamic> _$CartItemV2ToJson(CartItemV2 instance) {
  final val = <String, dynamic>{
    'itemId': instance.itemId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productQuantity', instance.productQuantity);
  val['price'] = instance.price;
  val['selectedSize'] = instance.selectedSize;
  val['selectedColor'] = instance.selectedColor;
  val['fabric'] = instance.fabric;
  val['collectionId'] = instance.collectionId;
  val['productTitle'] = instance.productTitle;
  val['productId'] = instance.productId;
  val['productImageUrl'] = instance.productImageUrl;
  writeNotNull('currency', instance.currency);
  writeNotNull('measurements', instance.measurements);
  val['productCreator'] = _convertCreator(instance.productCreator);
  return val;
}
