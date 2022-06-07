// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map json) {
  return Payment(
    referenceId: json['referenceId'] as String,
    paymentMethod: json['paymentMethod'] as int,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'referenceId': instance.referenceId,
      'paymentMethod': instance.paymentMethod,
    };
