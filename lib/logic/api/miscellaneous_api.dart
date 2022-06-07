

import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';

import '../restclient/restclient.dart';

/// MiscellaneousApi calls
class MiscellaneousApi {


  /// This method returns data about Awoshe subscription plans.
  static Future<Map<String, dynamic>> getSubscriptionPlans() async {

    try {

      var response = await restClient.getAsyncV2(
        resourcePath: EndPoints.SUBSCRIPTION_PLANS,
      );

      if (!response.success)
        throw response.message;

      return response.content;

    }

    catch (ex){
      print('MiscellaneousApi::getSubscriptionPlans $ex');
      throw ex;
    }
  }

//  static Future< Map<String, dynamic> > subscribe({ String planId, String tokenId, String userId, int amount }) async {
//
//    try {
//
//      Map<String, String> headers = {'userId': userId};
//
//      var response = restClient.postAsync(
//          headerParams: headers,
//          data: {
//            'token': tokenId,
//
//          },
//
//      );
//
//    }
//
//    catch(ex){
//      throw ex;
//    }
//
//  }
}