import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final String userId;
  final CollectionReference orderRef;
  final CollectionReference receivedOrderRef;

  OrderService(this.userId)
      : orderRef = Firestore.instance.collection("profiles/$userId/orders"),
        receivedOrderRef = Firestore.instance.collection("profiles/$userId/received_orders");

//  Future<DocumentReference> createOrder(Order order) async {
//    try {
//      print(order.toJson());
//      DocumentReference ref = await this.orderRef.add(order.toJson());
//      return ref;
//    } catch (e) {
//      print(e);
//      print("error while adding item to cart");
//    }
//    return null;
//  }

  Future<DocumentReference> changeOrderDeliveryStatus(String orderId, int status) async {
    try {
      DocumentReference _ref = receivedOrderRef.document(orderId);
      _ref.updateData({"deliveryStatus": status});
      return _ref;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
