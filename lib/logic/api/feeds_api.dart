import 'dart:async';
import 'dart:io';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/FeedCacheStore.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../endpoints.dart';

class FeedsApi {
  static Firestore _firestore = Firestore.instance;

  static Future<RestServiceResponse> fetchFeeds(
      {String userId, int page, int limit = 15}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    Map<String, String> queryParams = {"page": page.toString(), "limit": limit.toString()};
    print('fetching feeds for user: ' + userId);
    
    try {
        RestServiceResponse response = await restClient.getAsyncV2(
          resourcePath: EndPoints.FEEDS,
          queryParams: queryParams,
          headerParams: headerParams);

      print("Feeds Response________");
      print(response.message);
      
      if (!response.success) 
        throw Exception(response.message);
      
      FeedCacheStore.instance.setData(
        data: response.content, limit: limit.toString(), 
        page: page.toString(),type: CacheFeedType.MAIN
      );
      return response;

    } 
    
    on SocketException catch(_){
      return await _readFromCache( CacheFeedType.MAIN, page.toString(), limit.toString() );
    }
  
  }

  static Future<RestServiceResponse> _readFromCache(CacheFeedType type, String page, String limit ) async {
    var response;

    try {
      var data = await FeedCacheStore.instance.getData(
        limit: limit, page: page, type: type
      );
      response = RestServiceResponse(
        content: data,
        success: true,
        message: 'Status OK',
      );
    } 
    catch (ex){
      response = RestServiceResponse(
        content: null,
        success: false,
        message: ex.toString(),
      );
    }

    return response;

  }
  static Future<RestServiceResponse> fetchBannerFeeds(
      {String userId, int page, int limit = 15}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    Map<String, String> queryParams = {"page": page.toString(), "limit": limit.toString()};

    RestServiceResponse response;
    try {
      response = await restClient.getAsyncV2(
        resourcePath: EndPoints.BANNER_FEEDS,
        queryParams: queryParams,
        headerParams: headerParams);

    if (!response.success) 
      throw Exception(response.message);

     FeedCacheStore.instance.setData(
       data: response.content, type: CacheFeedType.BANNER,
       limit: limit.toString(),  page: page.toString(),
     );
    } 
    on SocketException catch (_){
      response = await _readFromCache(CacheFeedType.BANNER, page.toString(), limit.toString());
    }
    return response;
  }

  static Stream<QuerySnapshot> listenForNewFeeds() {
    return _firestore.collection('feeds').orderBy('createdOn', descending: true).snapshots();
  }

  static Future<void> favourite({String productId, String userId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: StringUtils.format(EndPoints.PRODUCT_FAVOURITE, [productId]),
        headerParams: headerParams,
        data: null);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Future<void> unFavourite({String productId, String userId}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;

    print(headerParams.toString());
    RestServiceResponse response = await restClient.deleteAsync(
        resourcePath: StringUtils.format(EndPoints.PRODUCT_FAVOURITE, [productId]),
        headerParams: headerParams);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }


}
