
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String referenceId;
  int paymentMethod;
  Payment({this.referenceId, this.paymentMethod});

  factory Payment.fromJson(Map<String,dynamic> json) =>
    _$PaymentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentToJson(this);
}