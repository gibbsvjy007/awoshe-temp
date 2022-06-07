// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designer_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DesignerOrderItem _$DesignerOrderItemFromJson(Map json) {
  return DesignerOrderItem(
    productId: json['productId'] as String,
    id: json['id'] as String,
    orderId: json['orderId'] as String,
    createdOn: _dateTimeFromEpochUs(json['createdOn'] as int),
    selectedColor: json['selectedColor'] as String,
    itemId: json['itemId'] as String,
    selectedSize: json['selectedSize'] as String,
    fabric: json['fabric'] as String,
    productCreator: json['productCreator'] == null
        ? null
        : Creator.fromJson(json['productCreator'] as Map),
    productImageUrl: json['productImageUrl'] as String,
    productTitle: json['productTitle'] as String,
    measurements: json['measurements'] == null
        ? null
        : Measurement.fromJson((json['measurements'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    billingAddress: json['billingAddress'] == null
        ? null
        : Address.fromJson((json['billingAddress'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    deliveryStatus: json['deliveryStatus'] as int,
    payment: json['payment'] == null
        ? null
        : Payment.fromJson((json['payment'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    price: json['price'] as String,
    productQuantity: json['productQuantity'] as int,
    shippingAddress: json['shippingAddress'] == null
        ? null
        : Address.fromJson((json['shippingAddress'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    creator: json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map),
  );
}

Map<String, dynamic> _$DesignerOrderItemToJson(DesignerOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'createdOn': instance.createdOn?.toIso8601String(),
      'productId': instance.productId,
      'itemId': instance.itemId,
      'productTitle': instance.productTitle,
      'measurements': instance.measurements,
      'fabric': instance.fabric,
      'selectedColor': instance.selectedColor,
      'selectedSize': instance.selectedSize,
      'price': instance.price,
      'deliveryStatus': instance.deliveryStatus,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'payment': instance.payment,
      'productQuantity': instance.productQuantity,
      'productCreator': instance.productCreator,
      'productImageUrl': instance.productImageUrl,
      'creator': instance.creator,
    };
