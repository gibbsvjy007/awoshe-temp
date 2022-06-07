
import 'package:Awoshe/models/plan/PlanMetadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Plan.g.dart';

@JsonSerializable()
class Plan {

  String id;
  String object;
  bool active;
  @JsonKey(
    name: 'aggregate_usage'
  )
  dynamic aggregateUsage;

  int amount;

  @JsonKey(
    name: 'amount_decimal'
  )
  String amountDecimal;
  @JsonKey(
    name: 'billing_scheme'
  )
  String billingScheme;
  int created;
  String currency;
  String interval;

  @JsonKey(
    name: 'interval_count'
  )
  int intervalCount;

  String nickname;
  String product;

  dynamic tiers;
  @JsonKey(
    name: 'tiers_mode'
  )
  dynamic tiersMode;

  @JsonKey(
    name: 'transform_usage'
  )
  dynamic transformUsage;

  @JsonKey(
    name: 'trial_period_days'
  )
  int trialPeriodDays;

  @JsonKey(
      name: 'usage_type'
  )
  String usageType;

  PlanMetadata metadata;

  Plan();

  factory Plan.fromJson( Map<String, dynamic>  json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}