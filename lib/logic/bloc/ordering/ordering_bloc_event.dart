import 'package:Awoshe/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum OrderingEventType {INIT, NAVIGATION, SUBMIT_CHECKOUT, CARD_VALIDATION, SET_PAYMENT_TYPE,
  UPDATE_ADDRESS }

enum OrderNavigation {SHIPPING, PAYMENT, CONFIRM_ORDER}

abstract class OrderingBlocEvent extends Equatable {
  final OrderingEventType eventType;
  OrderingBlocEvent({@required this.eventType});
}

class OrderingBlocCardValidationEvent extends OrderingBlocEvent {
  //final String message;

  final String cardNumber, cvc;
  final int  expiryMonth, expiryYear;
  final String cardOwnerName;

  OrderingBlocCardValidationEvent({
    @required this.cardNumber,
    @required this.cvc,
    @required this.expiryMonth,
    @required this.expiryYear,
    @required this.cardOwnerName}) : super(eventType : OrderingEventType.CARD_VALIDATION);
}

class OrderingBlocSetPaymentTypeEvent extends OrderingBlocEvent {
  final PaymentMethod paymentMethod;
  OrderingBlocSetPaymentTypeEvent(this.paymentMethod,) : super(eventType : OrderingEventType.SET_PAYMENT_TYPE);

}

class OrderingBlocSubmitCheckoutEvent extends OrderingBlocEvent {
  BuildContext context;
  OrderingBlocSubmitCheckoutEvent({@required this.context})
      : super(eventType: OrderingEventType.SUBMIT_CHECKOUT);
}

class OrderingBlocNavigationEvent extends OrderingBlocEvent{
  final OrderNavigation place;
  OrderingBlocNavigationEvent({this.place}) : super(eventType: OrderingEventType.NAVIGATION);
}

class OrderingBlocChangeAddressEvent extends OrderingBlocEvent {
  final String fullName;
  final int type;
  final String city;
  final String state;
  final String country;
  final String street;
  final String zipCode;

  OrderingBlocChangeAddressEvent({this.fullName, this.type, this.city,
      this.state, this.country, this.street, this.zipCode}) : super(eventType: OrderingEventType.UPDATE_ADDRESS);
}