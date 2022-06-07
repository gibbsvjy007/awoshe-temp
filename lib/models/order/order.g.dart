// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map json) {
  return Order(
    id: json['id'] as String,
    orderId: json['orderId'] as String,
    invoiceId: json['invoiceId'] as String,
    itemsTotal: (json['itemsTotal'] as num)?.toDouble(),
    taxCharge: (json['taxCharge'] as num)?.toDouble(),
    shippingCharge: (json['shippingCharge'] as num)?.toDouble(),
    total: (json['total'] as num)?.toDouble(),
    buyingGift: json['buyingGift'] as bool,
    shippingAddress: json['shippingAddress'] == null
        ? null
        : Address.fromJson((json['shippingAddress'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    billingAddress: json['billingAddress'] == null
        ? null
        : Address.fromJson((json['billingAddress'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    shippingAsBilling: json['shippingAsBilling'] as bool,
    orderItems: (json['orderItems'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItem.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    payment: json['payment'] == null
        ? null
        : Payment.fromJson((json['payment'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    createdOn: _dateTimeFromJson(json['createdOn'] as int),
    orderBy: json['orderBy'] as String,
    paymentMethod: json['paymentMethod'] as int,
    status: json['status'] as int,
    currency: json['currency'] as String ?? 'USD',
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'itemsTotal': instance.itemsTotal,
      'taxCharge': instance.taxCharge,
      'shippingCharge': instance.shippingCharge,
      'total': instance.total,
      'buyingGift': instance.buyingGift,
      'shippingAddress': instance.shippingAddress?.toJson(),
      'billingAddress': instance.billingAddress?.toJson(),
      'shippingAsBilling': instance.shippingAsBilling,
      'orderItems': instance.orderItems?.map((e) => e?.toJson())?.toList(),
      'payment': instance.payment?.toJson(),
      'currency': instance.currency,
      'invoiceId': instance.invoiceId,
      'status': instance.status,
      'createdOn': instance.createdOn?.toIso8601String(),
      'orderBy': instance.orderBy,
      'paymentMethod': instance.paymentMethod,
    };
