// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlanMetadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanMetadata _$PlanMetadataFromJson(Map json) {
  return PlanMetadata()
    ..include = json['include'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$PlanMetadataToJson(PlanMetadata instance) =>
    <String, dynamic>{
      'include': instance.include,
      'description': instance.description,
    };
