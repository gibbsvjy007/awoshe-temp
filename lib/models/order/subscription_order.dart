import '../plan/Plan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_order.g.dart';

@JsonSerializable()
class SubscriptionOrder{

  String designerId;
  Plan plan;
  int amount;
  String currency;

  SubscriptionOrder({this.designerId, this.plan, this.amount, this.currency});

  factory SubscriptionOrder.fromJson( Map<String, dynamic> json) 
    =>_$SubscriptionOrderFromJson(json);

  Map<String, dynamic>  toJson() => _$SubscriptionOrderToJson(this);

}