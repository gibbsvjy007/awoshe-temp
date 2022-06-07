import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FeedCacheManager extends BaseCacheManager {
  static final String key = 'feedCacheManager';
  String _url;

  String get url => _url;

  FeedCacheManager() : super(key,
    maxAgeCacheObject: CACHE_DURATION,
    maxNrOfCacheObjects: MAX_CACHE_OBJECTS,
  );

  @override
  Future<String> getFilePath() async {
    var directory = await getApplicationDocumentsDirectory();
    _url = join( directory.path, key);
    return _url;
  }

}