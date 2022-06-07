import 'package:Awoshe/logic/stores/cache/cache_manager/ProductCacheManager.dart';
import 'dart:convert';

class ProductCacheStore {
  static final ProductCacheStore _instance = ProductCacheStore._private();
  static final _extension = 'product';
  static ProductCacheStore get instance => _instance;

  final ProductCacheManager _manager = ProductCacheManager();
  //Map<String, dynamic> dataCached = {};

  ProductCacheStore._private();

  void addProduct(dynamic product, String productId) async {
    // if (dataCached.containsKey(productId))
    //   return;
    
    try {
      if (_manager.url == null)
        await _manager.getFilePath();
        var bytes = utf8.encode( json.encode( product ) );
        //print(bytes);
        _manager.putFile(productId, bytes,fileExtension: _extension);
    } 
    catch (ex){
      print('ProductCacheStore::addProduct $ex');
      throw ex;
    }
  }

  Future<Map<String,dynamic>> getData(String productId) async {
    try {
      if (_manager.url == null)
        await _manager.getFilePath();
      
      var fileInfo = await _manager.getFileFromCache(productId);
      if (fileInfo == null)
        return null;
        
      var bytes = fileInfo.file.readAsBytesSync();
      
      return Map<String, dynamic>.of( json.decode( utf8.decode(bytes) ) );
      
    } 
    catch (ex){
      print( 'ProductCacheStore::getData $ex' );
      throw ex;
    }
  }

  void clear(){
    _manager?.emptyCache();
  }

}