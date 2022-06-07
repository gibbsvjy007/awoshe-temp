// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadProgress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadProgress _$UploadProgressFromJson(Map json) {
  return UploadProgress(
    UploadProgress._getEnumValue(json['type'] as int),
    json['data'] as String,
  );
}

Map<String, dynamic> _$UploadProgressToJson(UploadProgress instance) =>
    <String, dynamic>{
      'type': UploadProgress._getEnumIndex(instance.type),
      'data': instance.data,
    };
