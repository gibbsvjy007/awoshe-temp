// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map json) {
  return Collection(
    description: json['description'] as String,
    title: json['title'] as String,
    displayType: getFeedType(json['displayType'] as int),
    orientation: json['orientation'] as String,
    id: json['id'] as String,
    ratioX: json['ratioX'] as int,
    ratioY: json['ratioY'] as int,
  );
}

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'description': instance.description,
      'title': instance.title,
      'displayType': getFeedTypeIndex(instance.displayType),
      'orientation': instance.orientation,
      'id': instance.id,
      'ratioX': instance.ratioX,
      'ratioY': instance.ratioY,
    };
