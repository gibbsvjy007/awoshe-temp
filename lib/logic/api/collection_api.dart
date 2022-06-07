import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:flutter/foundation.dart';

/// Basic API with CRUD operations under user -> collections.
class CollectionApi {

  /// This method creates a new Collection under user entry on database.
  /// [data] Collection json data to be stored. See Collection class.
  /// [userId] The current userId.
  static Future<RestServiceResponse> create( {
    @required Map<String,dynamic> data,
    @required String userId} ) async {
    Map<String,String> headersParam = {'userId' : userId };
    
    try {
      RestServiceResponse response = await restClient.postAsync(
          headerParams: headersParam,
          resourcePath: EndPoints.COLLECTION,
          data: data,
      );

      if (!response.success){
        print('CollectionApi::create ${response.message}');
        throw Exception(response.message);
      }

      return response;
    }

    catch (ex){
      print('CollectionApi::create $ex');
      throw ex;
    }
  }

  /// This method read and returns all collections created by
  /// the current user.
  /// [userId] The current user Id
  static Future<RestServiceResponse> read({@required String userId}) async{
    Map<String,String> headersParam = {'userId' : userId };

    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.COLLECTION,
        headerParams: headersParam,
      );

      if (response.success) {
        print('Collection READ success');
        return response;
      }

      else {
        print('CollectionApi::read ${response.message}');
        throw Exception(response.message);
      }
    }

    catch (ex){
      print('CollectionApi::read $ex');
      throw ex;
    }
  }

  //static update(){}

  static delete({@required String collectionId, @required String userId}){}
}