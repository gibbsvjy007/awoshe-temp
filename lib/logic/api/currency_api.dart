//import 'dart:convert';
//import 'package:Awoshe/constants.dart';
//import 'package:Awoshe/logic/restclient/rest_service_response.dart';
//import 'package:flutter/foundation.dart';
//import 'package:http/http.dart' as http;
//
//class CurrencyApi {
//  ///
//  /// [from] must be PRODUCT CURRENCY
//  /// [to] must be USER PREFERENCE CURRENCY
//  Future<RestServiceResponse> getExchangeRate(
//      {@required String from, @required String to}) async {
//    Map<String, String> queryParams = {
//      'apiKey': CURRENCY_API_KEY,
//      'q': '$from' + '_' + '$to',
//      'compact': 'ultra'
//    };
//
//    var uri = Uri.https(CURRENCY_HOST, CURRENCY_API, queryParams);
//
//    print(uri);
//    var response = await http.get(uri);
//    return _processResponse(response);
//  }
//
//  RestServiceResponse<T> _processResponse<T>(http.Response response) {
//    if (!((response.statusCode < 200) ||
//        (response.statusCode >= 300) ||
//        (response.body == null))) {
//      var jsonResult = response.body;
//      dynamic result = jsonDecode(jsonResult);
//
//      return new RestServiceResponse<T>(content: result, success: true);
//    } else {
//      dynamic errorResponse = response.body;
//      return new RestServiceResponse<T>(
//          success: false,
//          content: errorResponse,
//          message: "(${response.statusCode}) ${errorResponse.toString()}");
//    }
//  }
//}
