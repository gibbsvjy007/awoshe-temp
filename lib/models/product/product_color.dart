import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_color.g.dart';

@JsonSerializable()
class ProductColor {
  final String name;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final Color colorCode;

  ProductColor(this.name, this.colorCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductColor &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }

  factory ProductColor.fromJson(Map<String, dynamic> json) => _$ProductColorFromJson(json);

  Map<String, dynamic> toJson() => _$ProductColorToJson(this);
}

_fromJson(Color l) => throw UnimplementedError();
_toJson(Color l) => throw UnimplementedError();
