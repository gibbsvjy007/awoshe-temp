
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class StripePaymentApi {
  
  
  static Future<RestServiceResponse> createPaymentIntent({@required String uid, 
  @required String amount, @required String currency}) async {

    Map<String,String> headers = {
      'userId': uid,
      'currency': currency,
      'amount': amount,
    };


    try {
    
      var response = RestClient.processResponse( await http.post('https://$HOST/triggers-charge',
        body: {
          //'userId': uid,
          'currency': currency,
          'amount': amount,
        },
        headers: headers,
      ));

      if (!response.success)
        throw Exception(response.message);

      print('Intent data: ${response.content}');
      return response;



      // var response = await restClient.getAsyncV2(
      //   headerParams: headers,
      //   resourcePath: EndPoints.ORDER_STRIPE_PAYMENT_INTENT,
      // );

      // if (!response.success)
      //   throw Exception(response.message);

      //print('Intent data: ${response.content}');
      //return response;
    } 

    catch (ex){
      print('StripeApi::createPaymentIntent');
      throw ex;
    }
  }
}