import 'package:Awoshe/logic/bloc/ordering/ordering_bloc_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class OrderingBlocState extends Equatable {
  final OrderingEventType eventType;
  OrderingBlocState({@required this.eventType});
}

class InitState extends OrderingBlocState{
  InitState() : super(eventType: OrderingEventType.INIT);
}

class OrderingBlocBusy extends OrderingBlocState {
  OrderingBlocBusy({OrderingEventType eventType}) : super(eventType: eventType);
}

class OrderingBlocSuccess extends OrderingBlocState {
  OrderingBlocSuccess({OrderingEventType eventType}) : super(eventType: eventType);
}

class OrderingBlocError extends OrderingBlocState {
  final String message;
  OrderingBlocError({OrderingEventType eventType, this.message}) : super(eventType: eventType);
}

class OrderingBlocNavigation extends OrderingBlocState{
  final OrderNavigation place;
  OrderingBlocNavigation({OrderingEventType eventType, this.place}) :
        super(eventType: eventType);
}

//* BUSY (uploading, downloading, validating)
//* SUCCESS (uploading, downloading, validating)
//* ERROR (message)