import 'package:Awoshe/logic/api/order_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:flutter/foundation.dart';

class OrderServiceV2 {

  Future<Order> createOrder({@required String userId,
    @required Order order}) async {
    try {
      RestServiceResponse resp =
        await OrderApi.create(userId: userId, data: order.toJson());

      order.id = resp.content['id'];
      return order;
    }
    catch(ex){
      throw ex;
    }

  }

  Future<void> update({@required String userId,
    @required Order order}) async {

    try {
      await OrderApi.update(
        userId: userId,
        orderId: order.id,
        data: order.toJson(),
      );
      return;
    }
    catch(ex){
      throw ex;
    }
  }

  Future<void> delete({
    @required String userId,
    @required String orderId}) async {

    try {
      await OrderApi.delete(userId: userId, orderId: orderId);
      return;
    }
    catch(ex){
      throw ex;
    }
  }

  Future<Order> getOrder({
    @required String userId, @required String orderId}) async {

    try {
      var resp = await OrderApi.read(
          userId: userId,
          orderId: orderId
      );

      return Order.fromJson(resp.content);
    }
    catch(ex){
      throw ex;
    }
  }

  Future<List<Order>> getAll({@required String userId}) async {
    try {
      var resp = await OrderApi.readAll(userId: userId);

      return List<dynamic>.from( resp.content )
          .map<Order>( (json)=> Order.fromJson(json) )
          .toList();
    }
    catch(ex){
      throw ex;
    }
  }
}