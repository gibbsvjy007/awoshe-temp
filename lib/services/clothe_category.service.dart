import 'dart:async';
import 'dart:convert';
import 'package:Awoshe/logic/api/sizes_api.dart';
import 'package:Awoshe/models/category/ClotheCategory.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Service class for fetch clothes categories data from local json file
class ClotheCategoryService {
  /// Categories node name
  //static const _CATEGORIES_COLLECTION_NODE = "categories";

  static const _JSON_FILE = "assets/category_size.json";
  static Map<String, dynamic> _categoriesJsonMap;

  Future<Map<String, dynamic>> loadJsonFile() async {
    if (_categoriesJsonMap == null) {
      try {
        String data = await SizesApi.getSizesJson();
        //String data = await rootBundle.loadString(_JSON_FILE);
        _categoriesJsonMap = Map<String, dynamic>.from(json.decode(data));
      } catch (ex) {
        print('ClotheCategoryService::FAIL REQUESTING REMOTE SIZE JSON FILE $ex' );
        print('USING LOCAL FILE');
        String data = await rootBundle.loadString(_JSON_FILE);
        _categoriesJsonMap = Map<String, dynamic>.from(json.decode(data));
      }
    }
    return _categoriesJsonMap;
  }

  Future<List<ClotheCategory>> getAllCategories() async {
    await loadJsonFile();
    return _categoriesJsonMap.keys
        .map((key) => ClotheCategory.fromJson(_categoriesJsonMap[key]))
        .toList();
  }

  Future<ClotheCategory> getMainCategoryByName(String name) async {
    await loadJsonFile();
    return ClotheCategory.fromJson(
        _categoriesJsonMap[name.toLowerCase()] ?? {});
  }
}
