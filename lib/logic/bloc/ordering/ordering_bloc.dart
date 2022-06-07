import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/ordering/ordering_bloc_event.dart';
import 'package:Awoshe/logic/bloc/ordering/ordering_bloc_state.dart';
import 'package:Awoshe/logic/services/order_service_v2.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/order/credit_card.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/order/payment.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class OrderingBloc extends Bloc<OrderingBlocEvent, OrderingBlocState> {
  PaymentMethod paymentMethod = PaymentMethod.CARD;
  bool isLocal = true;

  final OrderServiceV2 _service = OrderServiceV2();
  final Order order;
  final UserStore userStore;

  CreditCard cardData;

  OrderingBloc({@required this.order, @required this.userStore}){
    PaystackPlugin.initialize(
        publicKey: !PROD_MODE ? PAYSTACK_PUBLIC_KEY_TEST : PAYSTACK_PUBLIC_KEY_PROD
    );
  }

  @override
  OrderingBlocState get initialState => InitState();

  @override
  Stream<OrderingBlocState> mapEventToState(OrderingBlocEvent event) async* {

    yield OrderingBlocBusy(eventType: event.eventType);

    switch(event.eventType){

      case OrderingEventType.INIT:
        try {
          print('Ordering BLoC init handling');
          if (!PaystackPlugin.sdkInitialized){
            await PaystackPlugin.initialize(
                publicKey: !PROD_MODE ? PAYSTACK_PUBLIC_KEY_TEST : PAYSTACK_PUBLIC_KEY_PROD
            );
          }
          yield OrderingBlocSuccess(eventType: event.eventType);
        }
        on PaystackSdkNotInitializedException catch (ex){
          yield OrderingBlocError(message: ex.message);
        }
        break;

      case OrderingEventType.SUBMIT_CHECKOUT:
        try {

          if (!PaystackPlugin.sdkInitialized){
            await PaystackPlugin.initialize(
                publicKey: !PROD_MODE ? PAYSTACK_PUBLIC_KEY_TEST : PAYSTACK_PUBLIC_KEY_PROD
            );
          }


//          var response = await _startPaystackCheckout( (event as OrderingBlocSubmitCheckoutEvent).context, accessCode );
//          if (response.status){
            await _storeOrderData(null);
            yield OrderingBlocSuccess(eventType: event.eventType);
          //}
//          else {
//            print('Something goes wrong!');
//            yield OrderingBlocError(
//                eventType: event.eventType, message: 'response.message');
//          }
        }
        on Exception catch (ex){
          yield OrderingBlocError(eventType: event.eventType, message: ex.toString());
        }
        break;

      case OrderingEventType.CARD_VALIDATION:
        var e = (event as OrderingBlocCardValidationEvent);

        PaymentCard paymentCard = PaymentCard(
            number: e.cardNumber,
            cvc: e.cvc,
            expiryMonth: e.expiryMonth,
            expiryYear: e.expiryYear,
            name: e.cardOwnerName
        );

        if ( paymentCard.isValid() ) {
          this.cardData = CreditCard(
              number: paymentCard.number,
              cvc: paymentCard.cvc,
              expiryMonth: paymentCard.expiryMonth,
              expiryYear: paymentCard.expiryYear,
              name: paymentCard.name,
              type: paymentCard.type
          );
          yield OrderingBlocSuccess(eventType: event.eventType);
        }
        else
          yield OrderingBlocError(eventType: event.eventType,
              message:"Credit card is Invalid. Please verify the information again." );
        break;

      case OrderingEventType.SET_PAYMENT_TYPE:
        paymentMethod = (event as OrderingBlocSetPaymentTypeEvent).paymentMethod;
        yield OrderingBlocSuccess(eventType: event.eventType);
        break;

      case OrderingEventType.NAVIGATION:
        print('Bloc navigation');
        var place = (event as OrderingBlocNavigationEvent).place;
        yield OrderingBlocNavigation(eventType: event.eventType, place: place);
        break;

      case OrderingEventType.UPDATE_ADDRESS:
        if (event is OrderingBlocChangeAddressEvent){
          var addr = Address(
            fullName: event.fullName,
            type: event.type,
            city: event.city,
            state: event.state,
            country: event.country,
            street: event.street,
            zipCode: event.zipCode,
          );

          var key = 'address1';
          if(event.type == 0 ){
            userStore.details.address1 = addr;
          }
          else {
            userStore.details.address2 = addr;
            key = 'address2';
          }

          var response = await userStore.updateProfile( { key : addr.toJson() } );

          if (response.success)
            yield OrderingBlocSuccess(eventType: event.eventType);
          else
            yield OrderingBlocError(eventType: event.eventType,
                message:"Was not possible update address." );
        }
        break;
    }
  }

  Future<void> _storeOrderData(CheckoutResponse response) async {
    /// if the transaction is successful then delete the items from the cart and create an order
    /// for the designer
    /// Trigger the cloud function for notifying the designer
    /// Attach the payment information with order
    Payment _payment = Payment(
        paymentMethod: paymentMethod.index,
        referenceId: 'response.reference id',
    );

    order.payment = _payment;
    try {
      await _service.createOrder(userId: userStore.details.id, order: order);
      return;
    }
    catch (ex){
      print("Error when upload the order");
      throw ex;
    }
  }


//  Future<String> _fetchAccessCodeFrmServer() async {
//    String url = '$PAYSTACK_BACKEND_URL_TEST/new-access-code';
//    String accessCode;
//
//    try {
//      http.Response response = await http.get(url);
//      accessCode = response.body;
//      print('Response for access code = $accessCode');
//    }
//    catch (e) {
//      print('There was a problem getting a new access code form'
//          ' the backend: $e');
//
//      throw Exception('There was a problem getting a new access code form '
//          'the backend: $e');
//    }
//    return accessCode;
//  }


}