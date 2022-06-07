import 'package:Awoshe/logic/api/collection_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/collection/collection.dart';
import 'package:flutter/foundation.dart';

class CollectionService {

  /// Create a new collection on database
  Future<Collection> createCollection({ @required Collection collection, @required String userId}) async {
    try {
      var response = await CollectionApi.create(data: collection.toJson(), userId: userId);
      collection.id = response.content['id'];
      return collection;
    }
    catch(ex){
      throw ex;
    }
  }

  /// This method gets all collections data from a specific user.
  /// [userId] The current userId.
  Future<List<Collection>> getAllCollections({@required String userId}) async {
    try{
      RestServiceResponse response = await CollectionApi.read(userId: userId);
      return (response.content == null) ? [] :
      List.from(response.content).map<Collection>(
              (data) => Collection.fromJson(data)).toList();
    }
    catch(ex){
      print('There is no collections');
      //throw ex;
    }

    return [];
  }
}