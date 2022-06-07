import 'dart:convert';
import 'dart:io';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/OcassionCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/ProductCacheStore.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/foundation.dart';
import '../endpoints.dart';

/// Api class with CRUD operations for products and favourite & unfavourite methods.
class ProductApi {
  /// This method creates a new product entry on database with POST http method.
  /// It returns a product if creation success or throws an exception
  /// if fails.
  ///
  /// [userId] The product creator user id.
  /// [productData] The product data in json format.
  static Future<RestServiceResponse> create(
      {@required Map<String, dynamic> productData,
      @required String userId}) async {
    RestServiceResponse response;

    try {
      var headerParam = <String, String>{'userId': userId};

      response = await restClient.postAsync(
          headerParams: headerParam,
          resourcePath: EndPoints.PRODUCT,
          data: productData);

      if (response.success) {
        print(response.success);
        //productData['id'] = response.content['id'];
        return response; //Product.fromJson(productData);
      } else
        throw Exception(response.message);
    } catch (ex) {
      print('ProductApi::create ${ex.toString()}');
      throw ex;
    }
  }

  /// This method update a product entry on database using PUT http method.
  /// It throws an exception if update process fails.
  ///
  /// [productId] The product id to be updated
  /// [productData] The product data in json format to be uploaded on database.
  /// [userId] The current user id.
  static Future<void> update(
      {@required String productId,
      @required Map<String, dynamic> productData,
      @required String userId}) async {
    RestServiceResponse response;
    var headersParam = <String, String>{'userId': userId};

    try {
      response = await restClient.putAsync(
          headerParams: headersParam,
          resourcePath: StringUtils.format(EndPoints.PRODUCT_ID, [productId]),
          data: productData);

      if (!response.success) {
        print(response.message);
        throw Exception(response.message);
      }
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }

  /// This method reads a single product by id from database.
  ///
  /// [productId] The product id.
  /// [userId] The current user id.
  static Future<RestServiceResponse> read(
      {@required String productId, @required String userId}) async {
    RestServiceResponse response;

    if (response == null) {
      try {
        var headersParam = <String, String>{'userId': userId};
        var path = StringUtils.format(EndPoints.PRODUCT_ID, [productId]);

        print('Using Path $path');

        response = await restClient.getAsyncV2(
            headerParams: headersParam, resourcePath: path);

        if (response.success && response.content != null) {
          print('PRODUCT READED REMOTE');
          print(response.success);
          ProductCacheStore.instance.addProduct(response.content, productId);
          return response;
        } else {
          print('ProductApi::read error: ${response.message}');
          throw Exception(response.message);
        }
      }
      // if network problems try to read data from cache
      on SocketException catch (ex) {
        response = await _readFromCache(productId);
        if (response == null) throw ex;
        return response;
      } catch (ex) {
        print(ex);
        throw ex;
      }
    } else {
      print('PRODUCT READED FROM CACHE');
      return response;
    }
  }

  static Future<RestServiceResponse> _readFromCache(String productId) async {
    RestServiceResponse response;

    try {
      var data = await ProductCacheStore.instance.getData(productId);
      if (data != null)
        response = RestServiceResponse(
          content: data,
          success: true,
          message: 'Status: OK',
        );
    } catch (ex) {
      print(ex);
    }

    return response;
  }

  /// This method delete a product from database. It throws an exception
  /// if the operation fails.
  ///
  /// [productId] The id of the product to be removed.
  /// [userId] The current user id.
  static Future<void> delete(
      {@required String productId, @required String userId}) async {
    var headersParam = <String, String>{'userId': userId};
    RestServiceResponse response;

    try {
      response = await restClient.deleteAsync(
          headerParams: headersParam,
          resourcePath:
              StringUtils.format('/${EndPoints.PRODUCT_ID}', [productId]));

      if (!response.success) {
        print(response.message);
        throw Exception(response.message);
      }
    } catch (ex) {
      print(ex);
      throw ex;
    }
  }

  /// This method add favourites a product.
  /// [productId] The product id to be favourited.
  /// [userId] The current userId
  static Future<void> favourite(
      {@required String productId, @required String userId}) async {
    Map<String, String> headersParam = {'userId': userId};

    try {
      RestServiceResponse response = await restClient.putAsync(
          resourcePath:
              StringUtils.format(EndPoints.PRODUCT_FAVOURITE, [productId]),
          headerParams: headersParam,
          data: null);
      if (!response.success) throw Exception(response.message);
    } catch (ex) {
      print('ProductApi::favourite $ex');
      throw ex;
    }
  }

  /// This method unfavourite a product.
  /// [productId] The product id to b unfavourited.
  /// [userId] The current user id.
  static Future<void> unfavourite(
      {@required String productId, @required String userId}) async {
    Map<String, String> headersParam = {'userId': userId};

    try {
      RestServiceResponse response = await restClient.deleteAsync(
        resourcePath:
            StringUtils.format('/${EndPoints.PRODUCT_FAVOURITE}', [productId]),
        headerParams: headersParam,
      );
      if (!response.success) throw Exception(response.message);
    } catch (ex) {
      print('ProductApi::unfavourite $ex');
      throw ex;
    }
  }

  /// This method gets products using a type filter. The type are the
  /// indexes of ProductType enum.
  /// [userId] The current user id.
  /// [type] The index type of ProductType enum.
  /// [page] The first page to be loaded. The default value is 0.
  /// [limit] The size of the page to be loaded. The default value is 10.

  static Future<RestServiceResponse> getProductsByType(
      {@required String userId,
      @required int type,
      int page = 0,
      int limit = 10}) async {
    Map<String, String> headerParams = {'userId': userId};
    Map<String, String> queryParams = {'page': '$page', 'limit': '$limit'};

    try {
      var response = await restClient.getAsyncV2(
          headerParams: headerParams,
          queryParams: queryParams,
          resourcePath: StringUtils.format(EndPoints.PRODUCT_TYPE, ['$type']));

      if (!response.success) {
        print('ProductApi::getProductsByType ${response.message}');
        throw Exception(response.message);
      }
      return response;
    } catch (ex) {
      print('ProductApi::getProductsByType $ex');
      throw ex;
    }
  }

  static Future<RestServiceResponse> getProductsByOccasion(
      {@required userId,
      @required occasion,
      int page = 0,
      int limit = 10}) async {
    var headers = <String, String>{'userId': userId};
    
    RestServiceResponse response;
    
    try {
      var encodedOccasion = base64Encode(utf8.encode(occasion));

      response = await restClient.getAsyncV2(
          headerParams: headers,
          queryParams: {'page': '$page', 'limit': '$limit'},
          resourcePath: StringUtils.format(
              EndPoints.PRODUCT_BY_OCCASION, [encodedOccasion]));

      if (!response.success) 
        throw Exception(response.message);

      // storing in cache
      _addProductsByOccasionToCache(
        key: occasion,
        data: response.content, page: '$page', limit: '$limit');
      return response;
    } 
    
    on SocketException catch (_) {
      response = await _readProductsByOccasionFromCache(key: occasion,
          limit: '$limit', page: '$page');

    } 
    
    catch (ex) {
      throw ex;
    }

    return response;
  }

  static Future<RestServiceResponse> _readProductsByOccasionFromCache(
      {String key, String page, String limit}) async {
    RestServiceResponse response;

    try {
      var data =
          await OcassionCacheStore.instance.getData(
            key: key,limit: limit, page: page);

      if (data == null)
        response = RestServiceResponse(
            success: false, content: null, message: 'No cached data');

      response = RestServiceResponse(
          success: true, content: data, message: 'Readed from cache');
    }

     catch (ex) {
      response = RestServiceResponse(
        success: false,
        content: null,
        message: ex.toString(),
      );
    }

    return response;
  }

  static Future<void> _addProductsByOccasionToCache(
      {String key, dynamic data, String page, String limit}) async {
    try {
      
      OcassionCacheStore.instance.setData(
        data: data, page: page, 
        key: key, limit: limit);

    } catch (ex) {
      print(
          'ProductAPO::_addProductsByOccasionToCache Not possible add data to cache! $ex)');
    }
  }
}
