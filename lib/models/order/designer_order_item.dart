import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/creator/creator.dart';
import 'package:Awoshe/models/measurement/measurement.dart';
import 'package:Awoshe/models/order/payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'designer_order_item.g.dart';

@JsonSerializable()
class DesignerOrderItem {
  String id;
  String orderId;

  @JsonKey(fromJson: _dateTimeFromEpochUs)
  DateTime createdOn;
  String productId;
  String itemId;
  String productTitle;
  Measurement measurements;
  String fabric;
  String selectedColor;
  String selectedSize;
  String price;
  int deliveryStatus;
  Address shippingAddress;
  Address billingAddress;
  Payment payment;
  int productQuantity;
  Creator productCreator;
  String productImageUrl;
  Creator creator;

  DesignerOrderItem({this.productId,
    this.id,
    this.orderId,
    this.createdOn,
    this.selectedColor,
    this.itemId,
    this.selectedSize,
    this.fabric,
    this.productCreator,
    this.productImageUrl,
    this.productTitle,
    this.measurements,
    this.billingAddress,
    this.deliveryStatus,
    this.payment,
    this.price,
    this.productQuantity,
    this.shippingAddress,
    this.creator
  });

  factory DesignerOrderItem.empty() {
    return DesignerOrderItem(
        id: ''
    );
  }

  factory DesignerOrderItem.fromJson(Map<String,dynamic> json) =>
      _$DesignerOrderItemFromJson(json);

  Map<String,dynamic> toJson() =>
      _$DesignerOrderItemToJson(this);
}

DateTime _dateTimeFromEpochUs(int us) =>
    DateTime.fromMillisecondsSinceEpoch(us ?? 0);