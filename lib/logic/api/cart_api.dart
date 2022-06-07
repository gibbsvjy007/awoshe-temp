import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:flutter/foundation.dart';

 class CartApi{

  /// This method reads the user cart.
  ///
  /// [userId] The current user id.
  static Future<RestServiceResponse> read({@required String userId}) async {
    Map<String, String> headersParam = {'userId': userId};
    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.CART,
        headerParams: headersParam,
      );

      if (!response.success)
        throw Exception(response.message);

      print('SUCCESS');
      return response;
    }
    catch (ex){
      print('CartApi::read $ex');
      throw ex;
    }
  }

  /// This method update the cart data.It can be used to add, remove item from cart
  /// also to increment and decrement an specific item inside the cart. We just
  /// need update the cart content to do that.
  ///
  /// [userId] The current userId
  /// [data] The cart data to be updated.
  static Future<RestServiceResponse> update({@required String userId,
    @required Map<dynamic, dynamic> data}) async {

    Map<String, String> headersParam = {'userId': userId};

    try {
      RestServiceResponse response = await restClient.putAsync(
        data: data,
        resourcePath: EndPoints.CART,
        headerParams: headersParam,
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }
    catch (ex){
      print('CartApi::update $ex');
      throw ex;
    }
  }

  /// This method will only CLEAR the cart and not DELETE the cart.
  /// The name delete is just for follow CRUD convention.
  /// [userId] The current user id.
  static Future<RestServiceResponse> delete({@required String userId}) async {
    Map<String, String> headersParam = {'userId': userId};
    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.CART_CLEAR,
        headerParams: headersParam,
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }
    catch (ex){
      print('CartApi::delete $ex');
      throw ex;
    }
  }

}