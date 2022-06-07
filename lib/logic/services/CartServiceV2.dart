import 'package:Awoshe/logic/api/cart_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/cart/cart_v2.dart';
import 'package:flutter/foundation.dart';

/// This class provides the basic methods to cart handling.
class CartServiceV2 {

  /// This method reads the cart of an user.
  ///
  /// [userId] The current user id.
  Future<CartV2> getCart( {@required String userId} ) async {
    try {
      RestServiceResponse resp = await CartApi.read(userId: userId);
      return CartV2.fromJson( resp.content );
    }
    
    catch(ex){
      throw ex;
    }
  }

  /// This method updates the cart.
  ///
  /// [userId] The current user id
  /// [cart] The cart to be uploaded
  Future<void> updateCart({@required CartV2 cart, @required String userId}) async {
    try {
      await CartApi.update(userId: userId, data: cart.toJson() );
      return;
    }

    catch(ex){

      throw ex;
    }
  }

  /// This method leaves the cart empty.
  ///
  /// [userId] The current user id.
  Future<void> clearCart({@required String userId}) async {
    try {
      await CartApi.delete(userId: userId);
    }
    catch(ex){
      throw ex;
    }
  }



}