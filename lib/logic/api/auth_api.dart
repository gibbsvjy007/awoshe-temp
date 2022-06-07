import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';

import '../endpoints.dart';

class AuthApi {

  static Future<void> registerUser({String uid,
    String email,
    String name,
    String handle,
    String deviceToken,
    String platform,
    bool isAnonymous,
    String pictureUrl,
    String thumbnailUrl
  }) async {

    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = uid;
    Map<String, dynamic> roles = {
      "admin": false,
      "user": true, /// default user should be true
      "designer": false
    };

    Map<String, dynamic> oData = {
      'uid': uid,
      'email': email,
      'name': name,
      'handle': handle,
      'deviceToken': deviceToken,
      'isAnonymous': isAnonymous,
      'platform': platform,
      'isPrivateProfile': false,
      'emailVerified': false,
      'roles': roles
    };

    if (pictureUrl != "" && pictureUrl != null && thumbnailUrl != "") {
      oData['pictureUrl'] = pictureUrl;
      oData['thumbnailUrl'] = thumbnailUrl;
    }
    RestServiceResponse response = await restClient.putAsync(
      resourcePath: EndPoints.USER_REGISTER,
      headerParams: headerParams,
      data: oData,
    );

    if (!response.success) throw Exception(response.message);

    return response;
  }

  static Future<bool> checkIfUsernameExists(String handle) async {
    Map<String, String> queryParams = {"key": 'handle', "value": handle};
    RestServiceResponse response = await restClient.getAsyncV2(
        resourcePath: EndPoints.USER_EXIST, queryParams: queryParams);

    if (!response.success) throw Exception(response.message);
    return response.content['exists'];
  }
}