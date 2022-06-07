// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductColor _$ProductColorFromJson(Map json) {
  return ProductColor(
    json['name'] as String,
    _fromJson(json['colorCode'] as Color),
  );
}

Map<String, dynamic> _$ProductColorToJson(ProductColor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colorCode': _toJson(instance.colorCode),
    };
