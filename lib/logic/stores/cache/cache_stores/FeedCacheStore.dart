import 'dart:convert';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/cache/cache_manager/FeedCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:path/path.dart';

enum CacheFeedType { BANNER, MAIN }

class FeedCacheStore {
  static final FeedCacheStore _instance = FeedCacheStore._private();
  static FeedCacheStore get instance => _instance;
  static final _extension = 'feed';
  final FeedCacheManager _manager = FeedCacheManager();
  final _mainFeed = 'mainFeeds';
  final _bannerFeed = 'bannerFeeds';

  FeedCacheStore._private();

  Future<void> setData(
      {dynamic data, CacheFeedType type, String page, String limit}) async {
    if (_manager.url == null) await _manager.getFilePath();

    try {
      var path = join(_manager.url, _transformType(type), page, limit);
      var bytes = utf8.encode(json.encode(data));
      _manager.putFile(path, bytes,
          fileExtension: _extension, maxAge: CACHE_DURATION);
    } 
    
    catch (ex) {
      print('FeedCacheStore::_save $ex');
      throw AppCacheException(
        message: ex.toString(),
      );
    }
  }

  Future<dynamic> getData({CacheFeedType type, String page, String limit}) async {
    try {
      if (_manager.url == null) await _manager.getFilePath();

      var path = join(_manager.url, _transformType(type), page, limit);
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

  String _transformType(CacheFeedType type) =>
      (type == CacheFeedType.MAIN) ? _mainFeed : _bannerFeed;

  void clear() => _manager?.emptyCache();
}
