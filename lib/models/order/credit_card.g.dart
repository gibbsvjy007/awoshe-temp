// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map json) {
  return CreditCard(
    number: json['number'] as String,
    cvc: json['cvc'] as String,
    expiryMonth: json['expiryMonth'] as int,
    expiryYear: json['expiryYear'] as int,
    name: json['name'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
      'cvc': instance.cvc,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'type': instance.type,
    };
