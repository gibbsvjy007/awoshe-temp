import 'package:Awoshe/logic/bloc/order/order_bloc_event_v2.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  final OrderBlocEvents eventType;
  OrderState(this.eventType);
}

class OrderStateInit extends OrderState {
  OrderStateInit() : super(OrderBlocEvents.INIT);
}

class OrderStateBusy extends OrderState {
  OrderStateBusy(OrderBlocEvents eventType) : super(eventType);
}

class OrderStateSuccess extends OrderState {
  OrderStateSuccess(OrderBlocEvents eventType) : super(eventType);
}

class OrderStateFail extends OrderState {
  final String message;

  OrderStateFail(OrderBlocEvents eventType,
      {this.message}) : super(eventType);
}