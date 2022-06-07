import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../constants.dart';
import 'rest_service_response.dart';

class RestClient {
  Map<String, String> defaultHeaders = {
    "Content-Type": 'application/json',
    "ACCEPT": 'application/json',
  };

  backendURL(endPoint) => '$BASE_URL$endPoint';

  Future<RestServiceResponse<T>> getAsync<T>(
      {String resourcePath, Map headerParams}) async {
    // String token = await this.getToken();
    // if (token == null)
    //   throw Exception("Token is invalid. Please contact administrator");

    // print("Token: " + token);
    Map<String, String> headers = Map<String, String>();
    headers.addAll(defaultHeaders);
    headers.addAll(headerParams);
    var response = await http.get(backendURL(resourcePath), headers: headers);
    return processResponse<T>(response);
  }

  Future<RestServiceResponse<T>> getAsyncV2<T>(
      {String resourcePath,
      Map headerParams,
      Map<String, String> queryParams}) async {
    // String token = await this.getToken();
    // if (token == null)
    //   throw Exception("Token is invalid. Please contact administrator");

    // print("Token: " + token);
    Map<String, String> headers = Map<String, String>();
    headers.addAll(defaultHeaders);
    if (headerParams != null) headers.addAll(headerParams);

    /// TODO - need to follow this at every where. currently following only for GET requests.

    Uri url;
    if (DEVELOPMENT_MODE) {
      url = Uri.http(HOST_LOCAL, HOST_LOCAL_TARGET + resourcePath, queryParams);
    } else {
      url = Uri.https(HOST, HOST_TARGET + resourcePath, queryParams, );
    }

    print(url);
    var response = await http.get(url, headers: headers, );
    return processResponse<T>(response);
  }

  Future<RestServiceResponse<T>> postAsync<T>({
    String resourcePath,
    Map<String, String> headerParams,
    @required Map<String, dynamic> data,
  }) async {
    // String token = await this.getToken();
    // if (token == null)
    //   throw Exception("Token is invalid. Please contact administrator");
    Map<String, String> headers = Map<String, String>();
    headers.addAll(defaultHeaders);
    headers.addAll(headerParams);
    // print("Token: " + token);
    String content;
    if (data != null) {
      content = json.encoder.convert(data);
    }
    Uri url;
    if (DEVELOPMENT_MODE) {
      url = Uri.http(HOST_LOCAL, HOST_LOCAL_TARGET + resourcePath);
    } else {
      url = Uri.https(HOST, HOST_TARGET + resourcePath);
    }
    print(url);
    var response = await http.post(url,
        body: content, headers: headers);
    print(response.body);
    return processResponse<T>(response);
  }

  Future<RestServiceResponse<T>> putAsync<T>({
    @required String resourcePath,
    Map<String, String> headerParams,
    @required Map<String, dynamic> data,
  }) async {
    // String token = await this.getToken();
    // if (token == null)
    //   throw Exception("Token is invalid. Please contact administrator");
    Map<String, String> headers = Map<String, String>();
    headers.addAll(defaultHeaders);
    headers.addAll(headerParams);
    // print("Token: " + token);
    var content = data != null ? json.encoder.convert(data) : "";
    print(content);

    Uri url;
    if (DEVELOPMENT_MODE) {
      url = Uri.http(HOST_LOCAL, HOST_LOCAL_TARGET + resourcePath);
    } else {
      url = Uri.https(HOST, HOST_TARGET + resourcePath);
    }
    print(url);

    var response = await http.put(url,
        body: content, headers: headers);
    print(response.body);
    return processResponse<T>(response);
  }

  Future<RestServiceResponse<T>> deleteAsync<T>({
    @required String resourcePath,
    Map<String, dynamic> headerParams,
  }) async {
    Map<String, String> headers = Map<String, String>();
    headers.addAll(defaultHeaders);
    headers.addAll(headerParams);
    // print("Token: " + token);
    Uri url;
    if (DEVELOPMENT_MODE) {
      url = Uri.http(HOST_LOCAL, HOST_LOCAL_TARGET + resourcePath);
    } else {
      url = Uri.https(HOST, HOST_TARGET + resourcePath);
    }
    print(url);
    var response =
        await http.delete(url, headers: headers);
    print(response.body);
    return processResponse<T>(response);
  }

  static RestServiceResponse<T> processResponse<T>(http.Response response) {
    if (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.body == null))) {
      var jsonResult = response.body;
      print("ProcessResponse_________");
      print(jsonResult.toString());
      if (jsonResult != null && jsonResult != "") {
        dynamic result = jsonDecode(jsonResult);
        return new RestServiceResponse<T>(content: result, success: true);
      } else {
        return new RestServiceResponse<T>(content: null, success: false);
      }

    } else {
      dynamic errorResponse = response.body;
      return new RestServiceResponse<T>(
          success: false,
          content: errorResponse,
          message: "(${response.statusCode}) ${errorResponse.toString()}");
    }
  }

  static RestServiceResponse<T> processHtmlResponse<T>(http.Response response) {
    if (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.body == null))) {
      
        
      if (response.body != null && response.body != "") {
        dynamic content = response.body;
        return new RestServiceResponse<T>(content: content, success: true);
      } 
      
      else {
        return new RestServiceResponse<T>(content: null, success: false);
      }

    } 
    
    else {
      dynamic errorResponse = response.body;
      return new RestServiceResponse<T>(
          success: false,
          content: errorResponse,
          message: "(${response.statusCode}) ${errorResponse.toString()}");
    }
  }
}

RestClient restClient = new RestClient();
