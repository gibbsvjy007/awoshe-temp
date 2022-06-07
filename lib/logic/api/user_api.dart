import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../endpoints.dart';

class UserApi {
  static Firestore _firestore = Firestore.instance;

  static Future<UserDetails> getUserProfile({String loggerInUser}) async {
    UserDetails userDetails;
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = loggerInUser;
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.MY_PROFILE, headerParams: headerParams);
    if (!response.success) throw Exception(response.message);
    if (response.content != null)
      userDetails = UserDetails.fromJson(response.content);

    return userDetails;
  }

  static Future<bool> checkIfEmailExists(String email) async {
    Map<String, String> queryParams = {"key": 'email', "value": email};
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.USER_EXIST, queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response.content['exists'];
  }

  static Future<RestServiceResponse> updateUserInfo(
      {Map<String, dynamic> oData, String currUserId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.USER,
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<RestServiceResponse> setPresence(
      {bool isActive, String currUserId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.USER_PRESENCE + '/' + isActive.toString(),
        headerParams: headerParams,
        data: null);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future< List<Product> > getDesigns({@required String userId,
    int page =0, int limit = 20}) async {


    var headersParam = <String,String>{'userId': userId};
    var queryParam;

    if (page >=0 && (limit > 0 )){
      queryParam = {'page':'$page', 'limit':'$limit'};
    }

    try {
      var response = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(EndPoints.USER_DESIGNS, [userId]),
        headerParams: headersParam,
        queryParams: queryParam,
      );

      if (!response.success) {
        print(response.message);
        throw Exception(response.message);
      }

      print('Data downloaded ${response.content}');
      return List<dynamic>.from( response.content )
          .map<Product>(
              (json) => Product.fromJson(json) ).toList();
    }

    catch (ex){
      print(ex);
      throw ex;
    }
  }

  static Future<RestServiceResponse> sendReviewTemplate(String currentUserId,
    {@required String orderId,
      @required String buyerId,}

      ) async {

    Map<String,String> header = {'userId' : currentUserId};

    try {
    //felix@awoshe.com
      var response = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(
            EndPoints.REVIEW_TEMPLATE, [orderId, buyerId]),
        headerParams: header
      );

      if (!response.success)
        throw Exception(response.message);

      print(response.content);
      return response;
    }
    catch (ex){
      print('ERROR IN UserApi::sendReviewTemplate $ex');
      throw ex;
    }
  }

  static Future<RestServiceResponse> submitProductReview(
      {@required String productId, @required String userId,
        @required Map<String, dynamic> data}) async {

    Map<String, String> header = {'userId': userId};

    try {
      var response  = await restClient.postAsync(
        headerParams: header, data: data,
        resourcePath: StringUtils.format(EndPoints.SUBMIT_REVIEW, [productId])
      );

      if (!response.success)
        throw Exception(response.message);

      print(response.content);
      return response;
    }

    catch(ex){
      print('ERROR IN UserApi::submitProductReview $ex');
     throw ex;
    }

  }

  static Future<RestServiceResponse> resetMessageCount(
      { @required String userId}) async {

    Map<String, String> header = {'userId': userId};

    try {
      var response  = await restClient.getAsyncV2(
          headerParams: header,
          resourcePath: EndPoints.MESSAGE_RESET_COUNT
      );

      if (!response.success)
        throw Exception(response.message);
      print("______________reset message count____________");
      print(response.content);
      return response;
    }

    catch(ex){
      print('ERROR IN UserApi::resetMessageCount $ex');
      throw ex;
    }

  }

  static Stream<DocumentSnapshot> listenMessageCount({String userId}) {
    return _firestore.collection('users').document(userId).snapshots(includeMetadataChanges: false);
  }


}
