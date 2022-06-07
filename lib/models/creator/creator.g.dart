// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Creator _$CreatorFromJson(Map json) {
  return Creator(
    handle: json['handle'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    thumbnailUrl: json['thumbnailUrl'] as String,
  );
}

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
      'handle': instance.handle,
      'id': instance.id,
      'name': instance.name,
      'thumbnailUrl': instance.thumbnailUrl,
    };
