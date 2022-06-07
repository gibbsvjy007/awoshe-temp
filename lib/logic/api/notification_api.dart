
import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:meta/meta.dart';

class NotificationApi {
  static Future<RestServiceResponse> getUserNotifications({
    @required String userId,
    @required int page,
    @required int limit,
  }) async {
    Map<String, String> queryParams = {
      "page": page.toString(),
      "limit": limit.toString()
    };
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    
    RestServiceResponse response;

    try {
      response = await restClient.getAsyncV2(
        resourcePath: EndPoints.USER_NOTIFICATION,
        queryParams: queryParams,
        headerParams: headerParams);
        
        if (!response.success) 
          throw Exception(response.message);
    } 
    catch(ex){
      throw ex;
    }
    
    return response;
  }

  static Future<RestServiceResponse> fireAction(
      {@required String notificationId,
      @required String currUserId,
      @required String action}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = currUserId;
    RestServiceResponse response = await restClient.putAsync(
        resourcePath: StringUtils.format(
            EndPoints.NOTIFICATION_ACTION, [notificationId, action]),
        headerParams: headerParams,
        data: null);

    if (!response.success) throw Exception(response.message);
    print(response.toString());
    return response;
  }
}
