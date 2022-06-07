import 'dart:async';
import 'package:Awoshe/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///  CartService class provide access to firestore cart read and write operations
///

class CartService {

  final String userId;
  static String cartId;
  static DocumentReference userRef;
  static CollectionReference cartRef;

  CartService(this.userId) {
    userRef = Firestore.instance.collection("users").document(userId);
    cartRef = userRef.collection("cart");
    //getUserCart();
  }

  Stream<QuerySnapshot> getCartItemsStream() {
    return Firestore.instance.collection("users").document(userId)
      .collection("cart").document(cartId).collection("cartItems")
        .snapshots();
  }
//
//  Future<String> getUserCart() async {
//    print("CARTSERVICE GET CART ID");
//
//    try {
////      SharedPreferences prefs = await SharedPreferences.getInstance();
////      cartId = prefs.get("CART_ID");
//      QuerySnapshot querySnapshot = await cartRef.getDocuments();
//      if (querySnapshot.documents.length > 0) {
//        querySnapshot.documents.forEach((doc) {
//          cartId = doc.documentID;
//        });
//      } else {
//        /// if cart does not exist then simple crate and cart
//        this.createCart();
//      }
//      print("GET CART ID " + cartId);
//    }
//
//    catch (e) {
//      print("error while fetching cart ID");
//      print(e.message);
//    }
//    return cartId;
//  }


  getCartId() async {
    return cartId;
  }

  Future<void> createCart() async {
    try {
      cartRef.add({'status': 'active'}).then((ref) {
        print(ref.get());
        cartId = ref.documentID;
        return ref.get();
      });
    } catch (e) {
      print("error while createing cart");
      print(e.message);
    }
  }

  Future<DocumentSnapshot> addToCart(CartItem item) async {
    try {
      DocumentReference ref =
          await cartRef.document(cartId)
              .collection('cartItems').add(item.toJson());
      return ref.get();
    }
    catch (e) {
      print("error while adding item to cart");
      print(e.message);
    }
    return null;
  }

  Future<void> addQuantity(int quantity, String itemId) async {
    try {
      cartRef
          .document(cartId)
          .collection('cartItems')
          .document('$itemId')
          .updateData({"quantity": quantity + 1});
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeQuantity(int quantity, String itemId) async {
    try {
      if (quantity == 1) return;
      cartRef
          .document(cartId)
          .collection('cartItems')
          .document('$itemId')
          .updateData({"quantity": quantity - 1});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCart(data) async {
    try {
      cartRef.document(cartId).updateData(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteItem(final CartItem item) {
    print('Removing cart item ${item.cartItemID}');
    return cartRef.document(cartId).collection('cartItems')
        .document(item.cartItemID)
        .delete();
  }

  /// delete all the cart items once order has been made
  Future<Null> emptyCart() async {
    try {
      QuerySnapshot querySnapshot = await cartRef.document(cartId).collection('cartItems').getDocuments();
      querySnapshot.documents.forEach((DocumentSnapshot doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      print(e);
    }
  }

//  Future<double> getItemsTotal() async {
//    print("getItemsTotal");
//    double value = 0.0;
//    QuerySnapshot querySnapshot =
//        await cartRef.document(cartId).collection('cartItems').getDocuments();
//    if (querySnapshot.documents.length > 0) {
//      for (int i = 0; i < querySnapshot.documents.length; i++) {
//        DocumentSnapshot doc = querySnapshot.documents[i];
//        int quantity = doc.data['quantity'];
//        print('ITEM QUANTITY ' + quantity.toString());
//        value = value + (int.parse(doc.data['price'])  * quantity);
//      }
//      print('ITEM TOTAL ' + value.toString());
//    }
//    print(value);
//    return value;
//  }
//
//  Future<double> getCartTotal() async {
//    double value = 0.0;
//    double shippingCharge = 20.0;
//    double tax = 25.0;
//
//    double itemsTotal = await this.getItemsTotal();
//    value = value + itemsTotal + shippingCharge + tax;
//
//    print("CART TOTAL " + value.toString());
//    return value;
//  }
}
