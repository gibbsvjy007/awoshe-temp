// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionOrder _$SubscriptionOrderFromJson(Map json) {
  return SubscriptionOrder(
    designerId: json['designerId'] as String,
    plan: json['plan'] == null
        ? null
        : Plan.fromJson((json['plan'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    amount: json['amount'] as int,
    currency: json['currency'] as String,
  );
}

Map<String, dynamic> _$SubscriptionOrderToJson(SubscriptionOrder instance) =>
    <String, dynamic>{
      'designerId': instance.designerId,
      'plan': instance.plan,
      'amount': instance.amount,
      'currency': instance.currency,
    };
