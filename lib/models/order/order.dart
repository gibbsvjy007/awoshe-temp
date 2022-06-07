import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/order/order_item.dart';
import 'package:Awoshe/models/order/payment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String id;
  String orderId;
  double itemsTotal;
  double taxCharge;
  double shippingCharge;
  double total;
  bool buyingGift;
  Address shippingAddress;
  Address billingAddress;
  bool shippingAsBilling;
  List<OrderItem> orderItems;
  Payment payment;
  @JsonKey(defaultValue: 'USD')
  String currency;

  String invoiceId;

//  @JsonKey(defaultValue: OrderStatus.PREPARING)
  int status;

  @JsonKey(
    fromJson: _dateTimeFromJson,
  )
  DateTime createdOn;
  String orderBy;
  int paymentMethod;

  Order({
    this.id,
    this.orderId,
    this.invoiceId,
    this.itemsTotal,
    this.taxCharge,
    this.shippingCharge,
    this.total,
    this.buyingGift = false,
    this.shippingAddress,
    this.billingAddress,
    this.shippingAsBilling = false,
    this.orderItems,
    this.payment,
    this.createdOn,
    this.orderBy,
    this.paymentMethod,
    this.status,
    this.currency});

  factory Order.empty() {
    return Order(
        id: ''
    );
  }

  factory Order.fromJson(Map<String, dynamic> json)=>
    _$OrderFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OrderToJson(this);
}


DateTime _dateTimeFromJson(int time) =>
    DateTime.fromMillisecondsSinceEpoch(time);
