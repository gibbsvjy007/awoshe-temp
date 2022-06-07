import 'dart:io';

import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/ChatMessageCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/UserChatCacheStore.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../endpoints.dart';

class MessageApi {
  static Firestore _firestore = Firestore.instance;

  static Future<RestServiceResponse> sendMessage({String message, String chatId, MessageType type, String userId, User receiver}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    headerParams['chatId'] = chatId;
    Map<String, dynamic> oData = {
      'message': message,
      'receiver': receiver,
      'messageType': type.index,
      'chatId': chatId
    };
    RestServiceResponse response = await restClient.postAsync(
        resourcePath: EndPoints.MESSAGE,
        headerParams: headerParams,
        data: oData);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }

  static Stream<QuerySnapshot> listenForMessage({String chatId}) {
    return _firestore.collection('chats/$chatId/messages').orderBy('createdOn', descending: true).snapshots();
  }

  static Future<RestServiceResponse> fetchChatMessages(
      {String userId, String chatId, int page, int limit = 15}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    Map<String, String> queryParams = {"page": page.toString(), "limit": limit.toString()};

    RestServiceResponse response;
    
    try {
      response = await restClient.getAsyncV2(
        resourcePath: EndPoints.MESSAGE + '/$chatId',
        queryParams: queryParams,
        headerParams: headerParams);

      if (!response.success) 
        throw Exception(response.message);
    
        print(response);
        ChatMessageCacheStore.instance.setData(data: response.content, chatId: chatId);
        return response;
    }
    
    on SocketException catch(_){
      response = await _fetchMessagesFromCache(chatId: chatId);
    }

    catch (ex){
      throw ex;
    }

    return response;
  }


  // userId, page, limit,
  static Future<RestServiceResponse> fetchUserChats(
      {String userId, int page, int limit = 15}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    var pageString = page.toString();
    var limitString = limit.toString();
    Map<String, String> queryParams = {"page": pageString, "limit": limitString};

    RestServiceResponse response;

    try {
      response = await restClient.getAsyncV2(
          resourcePath: EndPoints.MESSAGE,
          queryParams: queryParams,
          headerParams: headerParams);

      // request results is list of maps ()
      if (!response.success)
        throw Exception(response.message);
        print(response);

      UserChatCacheStore.instance.setData(data: response.content,
          userId: userId, page: pageString, limit: limitString);
    }

    on SocketException catch (_){
      response = await _fetchUserChatsFromCache(
          uid: userId, limit: limitString,
          page: pageString
      );
    }

    catch(ex){
      throw ex;
    }


    return response;
  }


  static Future<RestServiceResponse> _fetchMessagesFromCache({@required chatId}) async {
    RestServiceResponse response;

    try {
      var data = await ChatMessageCacheStore.instance.getData(chatId: chatId);
      response = RestServiceResponse(
          message: 'STATUS OK',
          content: data,
          success: true
      );
    }

    catch(ex){
      response = RestServiceResponse(
          message: ex.toString(),
          content: null,
          success: false
      );
    }

    return response;
  }

  static Future<RestServiceResponse> _fetchUserChatsFromCache({String uid, String page, String limit}) async {
    RestServiceResponse response;

    try {
      var data = await UserChatCacheStore.instance.getData(userId: uid, page: page, limit: limit);
      response = RestServiceResponse(
        message: 'STATUS OK',
        content: data,
        success: true
      );
    }

    catch(ex){
      response = RestServiceResponse(
          message: ex.toString(),
          content: null,
          success: false
      );
    }

    return response;
  }
}