// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map json) {
  return Plan()
    ..id = json['id'] as String
    ..object = json['object'] as String
    ..active = json['active'] as bool
    ..aggregateUsage = json['aggregate_usage']
    ..amount = json['amount'] as int
    ..amountDecimal = json['amount_decimal'] as String
    ..billingScheme = json['billing_scheme'] as String
    ..created = json['created'] as int
    ..currency = json['currency'] as String
    ..interval = json['interval'] as String
    ..intervalCount = json['interval_count'] as int
    ..nickname = json['nickname'] as String
    ..product = json['product'] as String
    ..tiers = json['tiers']
    ..tiersMode = json['tiers_mode']
    ..transformUsage = json['transform_usage']
    ..trialPeriodDays = json['trial_period_days'] as int
    ..usageType = json['usage_type'] as String
    ..metadata = json['metadata'] == null
        ? null
        : PlanMetadata.fromJson((json['metadata'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ));
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'active': instance.active,
      'aggregate_usage': instance.aggregateUsage,
      'amount': instance.amount,
      'amount_decimal': instance.amountDecimal,
      'billing_scheme': instance.billingScheme,
      'created': instance.created,
      'currency': instance.currency,
      'interval': instance.interval,
      'interval_count': instance.intervalCount,
      'nickname': instance.nickname,
      'product': instance.product,
      'tiers': instance.tiers,
      'tiers_mode': instance.tiersMode,
      'transform_usage': instance.transformUsage,
      'trial_period_days': instance.trialPeriodDays,
      'usage_type': instance.usageType,
      'metadata': instance.metadata,
    };
