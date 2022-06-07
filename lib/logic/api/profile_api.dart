import 'dart:io';

import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/ProfileCacheStore.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/utils/string_utils.dart';

import '../endpoints.dart';
import 'package:meta/meta.dart';

class ProfileApi {
  static Future<UserDetails> getUserProfile(
      {String userId, String currentUserId}) async {
    
    UserDetails userDetails;
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currentUserId;
    
    RestServiceResponse response;
    
    try {
      response  = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(EndPoints.USER_PROFILE, [userId]),
        headerParams: headerParams);

        if (!response.success) 
         throw Exception(response.message);
    
        if (response.content != null){
          userDetails = UserDetails.fromJson(response.content);
          ProfileCacheStore.instance.setData(response.content, userId);

        }
    
    } 
    
    on SocketException catch (_){
      response = await _readProfileFromCache(userId);
      userDetails = UserDetails.fromJson(response.content);
    }

    catch (ex){
      throw ex;  
    }
    
    return userDetails;
  }

  static Future<RestServiceResponse> _readProfileFromCache(String uid) async {
    RestServiceResponse response;
    try {
      var data = await ProfileCacheStore.instance.getData(uid);
      response = RestServiceResponse(
        content: data,
        message: 'STATUS OK',
        success: true
      );
    } 
    catch (ex){
      throw ex;
    }

    return response;
  }

  static Future<RestServiceResponse> contactDesinger({
    @required String desingerId,
    @required String currUserId,
    @required Map<String, dynamic> oData
  }) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;
    print('$currUserId conatcting to $desingerId');
    RestServiceResponse response = await restClient.postAsync(
        resourcePath: StringUtils.format(EndPoints.CONTACT, [desingerId]),
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<RestServiceResponse> followUser({
    @required String followingId,
    @required String currUserId,
  }) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;
    print('$currUserId wants to follow $followingId');
    try {
      RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.FOLLOW_USER + '/' + followingId,
        headerParams: headerParams,
        data: null);

    if (!response.success) 
      throw Exception(response.message);
    print(response.toString());
    return response;
    } 
    
    catch(ex){
      throw ex;
    }
  }

  static Future<RestServiceResponse> unFollowUser({
    @required String followingId,
    @required String currUserId,
  }) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;
    print('$currUserId wants to follow $followingId');
    RestServiceResponse response = await restClient.deleteAsync(
      resourcePath: EndPoints.FOLLOW_USER + '/' + followingId,
      headerParams: headerParams,
    );

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<RestServiceResponse> getFollowings({
    @required String userId,
    @required int page,
    @required int limit,
  }) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": limit.toString()
    };
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(EndPoints.USER_FOLLOWING, [userId]),
        queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response;
  }

  static Future<RestServiceResponse> getFollowers({
    @required String userId,
    @required int page,
    @required int limit,
  }) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": limit.toString()
    };
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(EndPoints.USER_FOLLOWER, [userId]),
        queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response;
  }

  static Future<RestServiceResponse> fetchOrders({
    @required String userId,
    @required int page,
    @required int limit,
  }) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": limit.toString()
    };
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.ORDER,
        headerParams: headerParams,
        queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response;
  }

  static Future<RestServiceResponse> fetchOrderDetail({
    @required String orderId,
    @required String userId
  }) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;

    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.ORDER + '/' + orderId,
        headerParams: headerParams,
    );

    if (!response.success) throw Exception(response.message);
    return response;
  }

  static Future<RestServiceResponse> getFavourites({
    @required String userId,
    @required int page,
    @required int limit,
  }) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": limit.toString()
    };
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: StringUtils.format(EndPoints.USER_FAVOURITES, [userId]),
        queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response;
  }

  static Future<RestServiceResponse> updateProfile(
      {Map<String, dynamic> oData, String currUserId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.SAVE_PROFILE,
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<RestServiceResponse> updateOrder(
      {Map<String, dynamic> oData, String userId, String orderId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.ORDER + '/' + orderId,
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<RestServiceResponse> saveProfile(
      {String name,
        String handle,
        String location,
        String description,
        String currUserId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;
    var oData = {
      'name': name,
      'handle': handle,
      'location': location,
      'description': description
    };
    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: EndPoints.SAVE_PROFILE,
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }
}