import 'package:Awoshe/models/order/order.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum OrderBlocEvents{INIT, READ, UPLOAD, UPDATE, READ_ALL, DELETE}

abstract class OrderEvent extends Equatable {

  final OrderBlocEvents eventType;
  OrderEvent(this.eventType);
}

class OrderEventInit extends OrderEvent {
  OrderEventInit() : super(OrderBlocEvents.INIT);
}

class OrderEventRead extends OrderEvent {
  final String userId;
  final String orderId;

  OrderEventRead({this.userId, this.orderId})
      : super(OrderBlocEvents.READ);
}

class OrderEventDelete extends OrderEvent {
  final String userId;
  final String orderId;

  OrderEventDelete({this.userId, this.orderId})
      : super(OrderBlocEvents.DELETE);
}

class OrderEventReadAll extends OrderEvent {
  final String userId;

  OrderEventReadAll({@required this.userId})
      : super(OrderBlocEvents.READ_ALL);
}

class OrderEventUpload extends OrderEvent {
  final Order order;
  final String userId;

  OrderEventUpload({@required this.order, @required this.userId})
      : super(OrderBlocEvents.UPLOAD);
}

class OrderEventUpdate extends OrderEvent {
  final Order order;
  final String userId;

  OrderEventUpdate({@required this.order, @required this.userId})
      : super(OrderBlocEvents.UPDATE);
}