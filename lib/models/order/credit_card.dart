import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card.g.dart';
@JsonSerializable()
class CreditCard {
  String name;
  String number;
  String cvc;
  int expiryMonth = 0;
  int expiryYear = 0;
  String type;

  CreditCard({@required this.number,
    @required this.cvc,
    @required this.expiryMonth,
    @required this.expiryYear,
    this.name,
    this.type});

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
    _$CreditCardFromJson(json);

  Map<String,dynamic> toJson() =>
      _$CreditCardToJson(this);
}