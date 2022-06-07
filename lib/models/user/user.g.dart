// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    online: json['online'] as bool,
    thumbnailUrl: json['thumbnailUrl'] as String,
    handle: json['handle'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'thumbnailUrl': instance.thumbnailUrl,
      'handle': instance.handle,
      'online': instance.online,
    };
