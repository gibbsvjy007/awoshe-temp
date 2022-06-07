import 'dart:convert';
import 'package:Awoshe/logic/stores/cache/cache_manager/CurrencyCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';

/// Singleton class wich provide an interface to store data in cache.
class CurrencyCacheStore {
  
  static final String key = 'currencyCacheManager';
  final CurrencyCacheManager _cacheManager = CurrencyCacheManager(key); 
  static CurrencyCacheStore _instance = CurrencyCacheStore._private();
  
  static CurrencyCacheStore get instance => _instance;
  CurrencyCacheManager get cacheManager => _cacheManager;
  Map<dynamic, dynamic> cacheData;

  CurrencyCacheStore._private();

  void setData( Map<dynamic, dynamic> data ){
     cacheData = data;
     print('saving currencies in ${_cacheManager.url}');
    _cacheManager.putFile(_cacheManager.url,  utf8.encode( json.encode(data) ), );
  }

  Future< Map<dynamic, dynamic> > getData() async {
    if (_cacheManager.url == null)
      await _cacheManager.getFilePath();

    var fileInfo = await _cacheManager.getFileFromCache(_cacheManager.url);
    var bytes = fileInfo.file.readAsBytesSync();
    cacheData = Map.of( json.decode(utf8.decode(bytes)) );

    if (cacheData == null || cacheData.isEmpty)
      throw AppCacheException(
        message: 'No currencies data cache'
      ); 

    return cacheData;
  }

  void clear() async {
    cacheData?.clear();
    _cacheManager.emptyCache();
  }
}
