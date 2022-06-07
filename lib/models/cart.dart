import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String productId;
  int quantity;
  String price;
  String selectedSize;
  String selectedColor;
  String fabric;
  String promotionId;
  String cartItemID;
  int createdOn;
  int updatedOn;
  // add Creator.

  Map<dynamic, dynamic> measurements = Map<dynamic, dynamic>();

  CartItem(
      {this.productId,
      this.quantity,
      this.price,
      this.selectedColor,
      this.promotionId,
      this.selectedSize,
      this.fabric,
      this.measurements});

  CartItem.fromJson(Map<String, dynamic> json)
      : productId = json != null ? json['productId'] : "",
        quantity = json != null ? json['quantity'] : 0,
        price = json != null ? json['price'] : "0.0",
        selectedSize = json != null ? json['selectedSize'] : "",
        selectedColor = json != null ? json['selectedColor'] : "",
        fabric = json != null ? json['fabric'] : "",
        promotionId = json != null ? json['promotionId'] : "",
        measurements =
            json != null ? json['measurements'] : Map<dynamic, dynamic>();


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartItem &&
              runtimeType == other.runtimeType &&
              cartItemID == other.cartItemID;

  @override
  int get hashCode => cartItemID.hashCode;

  CartItem.fromDocument(DocumentSnapshot document)
      : productId = document != null ? document.data['productId'] : "",
        cartItemID = document.documentID,
        quantity = document != null ? document.data['quantity'] : 0,
        price = document != null ? document.data['price'] : "0.0",
        selectedSize = document != null ? document.data['selectedSize'] : "",
        selectedColor = document != null ? document.data['selectedColor'] : "",
        fabric = document != null ? document.data['fabric'] : "",
        promotionId = document != null ? document.data['promotionId'] : "",
        measurements =
        document != null ? document.data['measurements'] : Map<dynamic, dynamic>();

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
        'price': price,
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
        'fabric': fabric,
        'promotionId': promotionId,
        'measurements': measurements
      };
}
