import 'package:Awoshe/models/creator/creator.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {

  int productQuantity;
  String itemId;
  String price;
  String selectedSize;
  String selectedColor;
  String fabric;
  String collectionId;
  String productId;
  Creator productCreator;
  String productTitle;
  String productImageUrl;
  @JsonKey(defaultValue: 'USD')
  String currency;
  Map<dynamic, dynamic> measurements = Map<dynamic, dynamic>();

  OrderItem({this.productId,
    this.productQuantity,
    this.itemId,
    this.price,
    this.selectedColor,
    this.collectionId,
    this.selectedSize,
    this.fabric,
    this.productCreator,
    this.productImageUrl,
    this.productTitle,
    this.measurements,
    this.currency
  });


  factory OrderItem.fromJson(Map<String,dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String,dynamic> toJson() =>
      _$OrderItemToJson(this);
}