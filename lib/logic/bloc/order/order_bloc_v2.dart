import 'package:Awoshe/logic/bloc/order/order_bloc_event_v2.dart';
import 'package:Awoshe/logic/bloc/order/order_bloc_state_v2.dart';
import 'package:Awoshe/logic/services/order_service_v2.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:bloc/bloc.dart';

class OrderBlocV2 extends Bloc<OrderEvent, OrderState>{

  final OrderServiceV2 _service = OrderServiceV2();
  Order currentOrder;
  List<Order> allOrders;
  @override
  OrderState get initialState => OrderStateInit();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {

    yield OrderStateBusy(event.eventType);

    switch(event.eventType){

      case OrderBlocEvents.INIT:
        print('Are get in init switch case?');
        break;

      case OrderBlocEvents.READ:
        if (event is OrderEventRead){
          try {
            currentOrder = await  _service.getOrder(
                userId: event.userId,
                orderId: event.orderId
            );
            yield OrderStateSuccess(event.eventType);
          }
          catch(ex){
            print('OrderBlocV2::${event.eventType} $ex');
            yield OrderStateFail(event.eventType,
              message: 'Was not possible read the order ${event.orderId}');
          }
        }
        break;

      case OrderBlocEvents.UPLOAD:
        if (event is OrderEventUpload){
          try {
            currentOrder = await _service.createOrder(userId: event.userId,
                order: event.order);
            yield OrderStateSuccess(event.eventType);
          }
          catch(ex){
            print('OrderBlocV2::${event.eventType} $ex');
            yield OrderStateFail(event.eventType,
                message: 'Was not possible upload the order');
          }
        }
        break;

      case OrderBlocEvents.UPDATE:
        if (event is OrderEventUpdate){
          try {
            await _service.update(userId: event.userId, order: event.order);
            yield OrderStateSuccess(event.eventType);
          }

          catch(ex){
            print('OrderBlocV2::${event.eventType} $ex');
            yield OrderStateFail(event.eventType,
                message: 'Was not possible update the order');
          }
        }
        break;

      case OrderBlocEvents.READ_ALL:
        if (event is OrderEventReadAll){
          try {

            var data = await _service.getAll(userId: event.userId);
            allOrders = data;
            yield OrderStateSuccess(event.eventType);
          }
          catch(ex){
            print('OrderBlocV2::${event.eventType} $ex');
            yield OrderStateFail(event.eventType,
                message: 'Was not possible read all orders');
          }
        }
        break;

      case OrderBlocEvents.DELETE:

        if(event is OrderEventDelete){
          try {
            await _service.delete(userId: event.userId,
                orderId: event.orderId);
            yield OrderStateSuccess(event.eventType);
          }
          catch(ex){
            print('OrderBlocV2::${event.eventType} $ex');
            yield OrderStateFail(event.eventType,
                message: 'Was not possible delete the order');
          }
        }
        break;
    }


  }

}