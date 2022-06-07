import 'dart:convert';
import 'dart:io';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/CategoryFeedCacheStore.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:flutter/services.dart';

import '../endpoints.dart';

class CategoryApi {
  static const _JSON_FILE = "assets/category_size.json";
  static Map<String, dynamic> _categoriesJsonMap;

  static Future<Map<String, dynamic>> loadJsonFile() async {
    if (_categoriesJsonMap == null) {
      String data = await rootBundle.loadString(_JSON_FILE);
      _categoriesJsonMap = Map<String, dynamic>.from(json.decode(data));
    }
    return _categoriesJsonMap;
  }

  static Future<List<ClotheCategory>> getAllCategories() async {
    await loadJsonFile();
    return _categoriesJsonMap.keys
        .map((key) => ClotheCategory.fromJson(_categoriesJsonMap[key]))
        .toList();
  }

  static Future<ClotheCategory> getMainCategoryByName(String name) async {
    await loadJsonFile();
    return ClotheCategory.fromJson(
        _categoriesJsonMap[name.toLowerCase()] ?? {});
  }

  static Future<RestServiceResponse> fetchProductsByCategory({String mainCategory, String subCategory, String userId, int page, int limit}) async {
    Map<String, String> headerParams = Map<String, String>();
    headerParams['userId'] = userId;
    RestServiceResponse response;
    Map<String, String> queryParams = {"page": page.toString(), "limit": limit.toString()};

     try {
       response = await restClient.getAsyncV2(
        resourcePath: EndPoints.PRODUCT + '/fetch/$mainCategory/$subCategory',
        queryParams: queryParams,
        headerParams: headerParams);
        
        if (!response.success) 
          throw Exception(response.message);
          
        // if success read store in cache!
        CategoryFeedCacheStore.instance.setData(
          response.content, mainCategory, subCategory, page.toString(), limit.toString());
    }

     on SocketException catch(_){
       response = await _readProductsByCategoryFromCache(
         mainCategory: mainCategory, subCategory: subCategory,
         page: page.toString(), limit: limit.toString(),
       );
     }
     
     catch(ex){
       throw ex;
     }
    
    print(response);
    return response;
  }

  static Future<RestServiceResponse> _readProductsByCategoryFromCache(
    {String mainCategory, String subCategory, String page, String limit} ) async {

      try {
        var cached = await CategoryFeedCacheStore.instance.getData(mainCategory, subCategory, page, limit);
        return RestServiceResponse(
          content: cached,
          message: 'STATUS OK',
          success: true,
        );
      } 
      
      catch (ex){
        throw ex;
      }
    } 
}
