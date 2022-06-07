
import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/foundation.dart';

/// This class provide the basic CRUD operations
/// to BLOG posts.
class BlogApi {

  /// This method creates a new blog entry on database.

  /// [userId] The current userId
  /// [data] The data to be uploaded
  static Future<RestServiceResponse> create(
      {@required String userId, @required Map<String,dynamic> data})  async {

    Map<String,String> headersParam = {'userId' : userId};

    try {
      RestServiceResponse response = await restClient.postAsync(
        headerParams: headersParam,
        data: data,
        resourcePath:EndPoints.BLOG,
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }
    catch (ex){
      print('BlogAPI::createBlog $ex');
      throw ex;
    }
  }


  /// This method update a specific blog entry on database.
  ///
  /// [userId] The current userId.
  /// [blogId] The blog id to be updated.
  /// [data] The updated data.
  static Future<RestServiceResponse> update({@required String userId,
  @required String blogId, @required Map<String,dynamic> data}) async {
    Map<String,String> headersParam = {'userId' : userId};
    
    try {
      RestServiceResponse response = await restClient.putAsync(
          headerParams: headersParam,
          resourcePath: StringUtils.format(EndPoints.BLOG_ID, [blogId]),
          data: data
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }

    catch(ex){
      print('BlogAPI::update $ex');
      throw ex;
    }
  }


  /// This method read an blog entry using blog id.
  ///
  /// [userId] The current user id.
  /// [blogId] The blog id to be read.
  static Future<RestServiceResponse> read({@required String userId,
    @required String blogId}) async {
    Map<String,String> headersParam = {'userId' : userId};

    try{
      RestServiceResponse response = await restClient.getAsyncV2(
        headerParams: headersParam,
        resourcePath: StringUtils.format(EndPoints.BLOG_ID, [blogId])
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }

    catch (ex){
      print('BlogAPI::read $ex');
      throw ex;
    }
  }


  /// This method delete a blog entry on database.

  /// [userId] The current user id.
  /// [blogId] The blog id to be deleted.
  static Future<RestServiceResponse> delete({@required String userId,@required String blogId }) async {
    Map<String,String> headersParam = {'userId' : userId};

    try{
      RestServiceResponse response = await restClient.deleteAsync(
          headerParams: headersParam,
          resourcePath: '/${StringUtils.format(EndPoints.BLOG_ID, [blogId])}'
      );

      if (!response.success)
        throw Exception(response.message);

      return response;
    }

    catch (ex){
      print('BlogAPI::delete $ex');
      throw ex;
    }
  }
  /// This method read all BLOG entries existent.
  ///
  /// [userId] The current userId.
  static Future<RestServiceResponse> readAll({@required String userId}) async {
    Map<String,String> headersParam = {'userId' : userId};
    try {
      RestServiceResponse response = await restClient.getAsyncV2(
        headerParams: headersParam,
        resourcePath: EndPoints.BLOG
      );
      if (!response.success)
        throw Exception(response.message);
      return response;
    }

    catch(ex){
      print('BlogAPI::readAll $ex');
      throw ex;
    }
  }
}