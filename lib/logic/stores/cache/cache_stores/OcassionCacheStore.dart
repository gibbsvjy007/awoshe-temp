import 'dart:convert';

import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/cache/cache_manager/OcassionCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class OcassionCacheStore {
  
  static final OcassionCacheStore _instance = OcassionCacheStore._private();
  static OcassionCacheStore get instance => _instance;
  final OcassionCacheManager _manager = OcassionCacheManager();
  OcassionCacheStore._private();


  /// The parameter key is an unique identifier. Can be the occasion name.
  Future<void> setData(
      {@required dynamic data,
      @required String key, 
      @required String page,
      @required String limit}) async {
    if (_manager.url == null) await _manager.getFilePath();

    try {
      var path = join(_manager.url, key, page, limit);
      var bytes = utf8.encode(json.encode(data));
      _manager.putFile(path, bytes,maxAge: CACHE_DURATION);
    } 
    
    catch (ex) {
      print('FeedCacheStore::_save $ex');
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  /// The parameter key is an unique identifier.
  Future<dynamic> getData({@required String key, @required String page, @required String limit}) async {
    try {
      if (_manager.url == null) await _manager.getFilePath();

      var path = join(_manager.url, key, page, limit);
      var fileInfo = await _manager.getFileFromCache(
        path,
      );
      var bytes = fileInfo.file.readAsBytesSync();
      return List<dynamic>.of(json.decode(utf8.decode(bytes)));
    } 
    
    catch (ex) {
      print('FeedCacheStore::getData $ex');
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

}