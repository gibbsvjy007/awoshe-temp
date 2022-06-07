import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/foundation.dart';

class OfferApi {

  static Future< Map<String, dynamic> > createOffer({@required String userId,
    @required String productId, Map<String, dynamic> data}) async {

    Map<String, String> headerParams = {'userId': userId};

    try {

      var response = await restClient.postAsync(
        headerParams: headerParams,
        resourcePath: StringUtils.format(EndPoints.OFFER_REQUEST, [productId]),
        data: data,
      );

      if (!response.success){
        print('Not possible create an offer');
        throw Exception(response.message);
      }

      print(response);
      return response.content;

    }

    catch (ex){
      throw ex;
    }
  }


  static Future<Map<String, dynamic>> approveOffer(
  {@required String userId, @required String productId, Map<String, dynamic> data} ) async {
    Map<String, String> headerParams = {'userId': userId};

    try {

      var response = await restClient.postAsync(
        resourcePath: StringUtils.format(EndPoints.OFFER_APPROVE, [productId]),
        headerParams: headerParams,
        data: data,
      );

      if (!response.success){
        print('Was not possible approve this offer');
        throw Exception(response.message);
      }

      return response.content;
    }

    catch (ex){
      throw ex;
    }

  }


  static Future<Map<String, dynamic>> getOfferRequest({
    @required String userId, @required String offerId, @required String designerId}) async {

    Map<String, String> headers = {'userId': userId};

    try {
      var path = StringUtils.format(
          EndPoints.OFFER_DETAILS_REQUEST, [offerId, designerId]);

      var response = await restClient.getAsyncV2(
        headerParams: headers,
        resourcePath: path,
      );

      if (!response.success)
        throw Exception(response.message);

      return response.content;
    }
    catch (ex){

      throw ex;
    }
  }

  static Future<Map<String, dynamic>> getOfferApprove({
    @required String userId, @required String offerId, @required String designerId}) async {

    Map<String, String> headers = {'userId': userId};

    try {
      var response = await restClient.getAsyncV2(
          headerParams: headers,
          resourcePath: StringUtils.format(
              EndPoints.OFFER_DETAILS_APPROVE, [offerId, designerId])
      );

      if (!response.success)
        throw Exception(response.message);

      return response.content;
    }
    catch (ex){
      throw ex;
    }
  }
}