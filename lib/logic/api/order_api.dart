import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/foundation.dart';

/// This class provides the basic CRUD operation for orders.
class OrderApi {

  /// This method creates a new order on database.
  ///
  /// [userId] The current user id.
  /// [data] The order data.
  static Future<RestServiceResponse> create({@required String userId,
    @required Map<String, dynamic> data}) async {
    Map<String,String> headerParam = {'userId':userId};
    try {
      RestServiceResponse response = await restClient.postAsync(
          headerParams: headerParam,
          data: data,
          resourcePath: EndPoints.ORDER
      );

      if (!response.success){
        print('OrderApi::create ${response.message}');
        throw Exception(response.message);
      }
      return response;
    }

    catch(ex){
      print('OrderApi::create $ex');
      throw ex;
    }
  }

  /// This method update data of a specific order.
  ///
  /// [userId] The current userId
  /// [orderId] The id of the order to be updated.
  /// [data] Order data to be uploaded.
  static Future<RestServiceResponse> update({@required String userId,
    @required String orderId, Map<String,dynamic> data}) async {

    Map<String,String> headerParam = {'userId':userId};
    try {

      RestServiceResponse response = await restClient.putAsync(
          headerParams: headerParam,
          resourcePath: StringUtils.format(EndPoints.ORDER_ID, [orderId]),
          data: data,
      );

      if (!response.success){
        print('OrderApi::update ${response.message}');
        throw Exception(response.message);
      }
      return response;

    }

    catch(ex){
      print('OrderApi::update $ex');
      throw ex;
    }
  }

  /// This method read a specific order from database.
  ///
  /// [userId] The current user id.
  /// [orderId] The id of the order to be retrieved.
  static Future<RestServiceResponse> read({@required String userId,
    @required String orderId}) async {

    Map<String,String> headerParam = {'userId':userId};
    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        headerParams: headerParam,
        resourcePath: StringUtils.format(EndPoints.ORDER_ID, [orderId])
      );

      if (!response.success){
        print('OrderApi::read ${response.message}');
        throw Exception(response.message);
      }
      return response;
    }

    catch(ex){
      print('OrderApi::read $ex');
      throw ex;
    }
  }

  static Future<RestServiceResponse> readAll({@required String userId}) async {
    Map<String,String> headerParam = {'userId':userId};
    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        headerParams: headerParam,
        resourcePath: EndPoints.ORDER,
      );

      if (!response.success){
        print('OrderApi::readAll ${response.message}');
        throw Exception(response.message);
      }
      return response;

    }
    catch(ex){
      print('OrderApi::readAll $ex');
      throw Exception(ex);
    }
  }

  /// This method deletes an order.
  ///
  /// [userId] The current user id.
  /// [orderId] The identification of the order to be removed.
  static Future<RestServiceResponse> delete({@required String userId,
    @required String orderId}) async {

    Map<String,String> headerParam = {'userId':userId};

    try {
      RestServiceResponse response = await restClient.deleteAsync(
        headerParams: headerParam,
        resourcePath: '/${StringUtils.format(EndPoints.ORDER_ID, [orderId])}'
      );

      if (!response.success){
        print('OrderApi::delete ${response.message}');
        throw Exception(response.message);
      }
      return response;
    }

    catch (ex){
      print('OrderApi::delete $ex');
      throw ex;
    }
  }

}