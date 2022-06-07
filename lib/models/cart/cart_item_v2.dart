import 'package:Awoshe/models/creator/creator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_v2.g.dart';

@JsonSerializable()
class CartItemV2 extends Equatable {
  String itemId;
  @JsonKey(includeIfNull: false)
  int productQuantity;
  String price;
  String selectedSize;
  String selectedColor;
  String fabric;
  String collectionId;
  String productTitle;
  String productId;
  String productImageUrl;
  @JsonKey(includeIfNull: false)
  String currency;

  @JsonKey(includeIfNull: false)
  Map<dynamic, dynamic> measurements = Map<dynamic, dynamic>();

  @JsonKey(toJson: _convertCreator)
  Creator productCreator;

  CartItemV2({
    @required this.productId,
    this.productQuantity,
    @required this.price,
    this.selectedColor,
    this.collectionId,
    this.selectedSize,
    this.productImageUrl,
    this.itemId,
    this.fabric,
    this.currency,
    @required this.productCreator,
    @required this.productTitle,
    this.measurements});

  factory CartItemV2.fromJson(Map<String, dynamic> json) =>
    _$CartItemV2FromJson(json);

  Map<String,dynamic> toJson() => _$CartItemV2ToJson(this);

  @override
  String toString() {
    return 'ID: $itemId'
        ' PRICE: $price';
  }
}

Map _convertCreator(Creator c) => c.toJson();