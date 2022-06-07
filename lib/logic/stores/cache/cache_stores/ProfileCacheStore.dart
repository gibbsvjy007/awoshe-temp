import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/cache/cache_manager/ProfileCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:path/path.dart';
import 'dart:convert';

class ProfileCacheStore {
  
  static final ProfileCacheStore _instance = ProfileCacheStore._private();
  static ProfileCacheStore get instance => _instance;
  final ProfileCacheManager _manager = ProfileCacheManager();

  ProfileCacheStore._private();

  Future<void> setData(dynamic data, String uid) async {
    try {
      if (_manager.url == null)
        await _manager.getFilePath();

      var path = join(_manager.url, uid);
      var bytes = utf8.encode( json.encode( data ) );
      _manager.putFile(path, bytes, maxAge: CACHE_DURATION);
    } 
    
    catch (ex){
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  Future<dynamic> getData(String uid) async {
    try {
      if (_manager.url == null)
        await _manager.getFilePath();

      var path = join(_manager.url, uid);
      var fileInfo = await _manager.getFileFromCache(path);
      var bytes = fileInfo.file.readAsBytesSync();
      return json.decode( utf8.decode( bytes) );
    } 
    
    catch (ex){
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  void clean() => _manager?.emptyCache();
}