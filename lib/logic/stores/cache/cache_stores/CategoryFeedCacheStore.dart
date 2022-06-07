import 'package:Awoshe/logic/stores/cache/cache_manager/CategoryFeedCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'dart:convert';
import 'package:path/path.dart';

class CategoryFeedCacheStore {

  static final CategoryFeedCacheStore _instance = CategoryFeedCacheStore._private();
  static CategoryFeedCacheStore get instance => _instance;

  final CategoryFeedCacheManager _manager = CategoryFeedCacheManager();
  
  CategoryFeedCacheStore._private();

  void clear() async {
    
    _manager?.emptyCache();
  }
  Future<void> setData( dynamic data, String mainCategory, String subcategory, String page, String limit ) async {
    if (data.isEmpty)
      return;
    
    try {

      if ( _manager.url == null )
        await _manager.getFilePath();

        var bytes = utf8.encode( json.encode(data) );
        _manager.putFile( join( _manager.url, mainCategory, subcategory, page, limit) , bytes);

    }

    catch (ex){
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  Future<dynamic> getData(String mainCategory, String subcategory,String page, String limit) async {
    try {
      if ( _manager.url == null )
        await _manager.getFilePath();

      var fileInfo = await _manager.getFileFromCache(  join(_manager.url,  
        mainCategory, subcategory, page, limit) );
      var data = json.decode( utf8.decode( fileInfo.file.readAsBytesSync()  ) );
      
      return data;

    }
     catch (ex){
       throw AppCacheException(
        message: ex.toString(),
      );   
    }
  }


}