import 'package:Awoshe/logic/stores/cache/cache_manager/ChatMessageCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'dart:convert';

class ChatMessageCacheStore {
  static final ChatMessageCacheStore _instance =
      ChatMessageCacheStore._private();
  static ChatMessageCacheStore get instance => _instance;

  final ChatMessageCacheManager _manager = ChatMessageCacheManager();

  ChatMessageCacheStore._private();

  Future<dynamic> getData({String chatId}) async {
    try {
      await _checkManagerPath();
      var url = join(_manager.url, chatId);
      var fileInfo = await _manager.getFileFromCache(url);

      var bytes = fileInfo.file.readAsBytesSync();
      return jsonDecode(utf8.decode(bytes));
    } catch (ex) {
      throw AppCacheException(message: ex.toString());
    }
  }

  Future<void> setData({dynamic data, String chatId}) async {
    try {
      await _checkManagerPath();

      var url = join(_manager.url, chatId);

      var bytes = utf8.encode(json.encode(data));
      _manager.putFile(url, bytes);
    } catch (ex) {
      print('setData::setData $ex');
      throw AppCacheException(message: ex.toString());
    }
  }

  Future<void> removeFromCache({@required String chatId}) async {}

  void clean() => _manager?.emptyCache();

  Future<void> _checkManagerPath() async {
    if (_manager.url == null) await _manager.getFilePath();
  }
}
