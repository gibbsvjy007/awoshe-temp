// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map json) {
  return Measurement(
    height: (json['height'] as num)?.toDouble() ?? 0.0,
    hip: (json['hip'] as num)?.toDouble() ?? 0.0,
    chest: (json['chest'] as num)?.toDouble() ?? 0.0,
    waist: (json['waist'] as num)?.toDouble() ?? 0.0,
    burst: (json['burst'] as num)?.toDouble() ?? 0.0,
    arms: (json['arms'] as num)?.toDouble() ?? 0.0,
  );
}

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'height': instance.height,
      'hip': instance.hip,
      'chest': instance.chest,
      'waist': instance.waist,
      'burst': instance.burst,
      'arms': instance.arms,
    };
