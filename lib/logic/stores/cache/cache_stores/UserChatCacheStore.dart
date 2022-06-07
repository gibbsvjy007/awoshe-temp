import 'dart:convert';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:path/path.dart';
import 'package:Awoshe/logic/stores/cache/cache_manager/UserChatCacheManager.dart';
import 'package:flutter/foundation.dart';

class UserChatCacheStore {
  static final UserChatCacheStore _instance = UserChatCacheStore._private();
  static UserChatCacheStore get instance => _instance;
  final UserChatCacheManager _manager = UserChatCacheManager();

  UserChatCacheStore._private();

  Future<dynamic> getData({@required String userId, @required String page, @required String limit}) async {

    try {
      if (_manager.url == null)
        await _manager.getFilePath();

      var path = join(_manager.url, userId, page, limit);

      var fileInfo = await _manager.getFileFromCache(path);

      var bytes = fileInfo.file.readAsBytesSync();
      return json.decode( utf8.decode(bytes) );
    }

    catch(ex){
      print('UserChatCacheStore::getData $ex');
      throw AppCacheException(
        message: ex.toString(),
      );

    }
  }

  Future<void> setData({@required dynamic data, @required String userId,
    @required String page, @required String limit}) async {

    try {

      if (_manager.url == null)
        await _manager.getFilePath();

      var path = join(_manager.url, userId, page, limit);
      var bytes = utf8.encode( json.encode( data ) );
      _manager.putFile(path, bytes);

    }

    catch (ex){
      print('UserChatCacheStore::setData $ex');
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  void clear() => _manager?.emptyCache();

}