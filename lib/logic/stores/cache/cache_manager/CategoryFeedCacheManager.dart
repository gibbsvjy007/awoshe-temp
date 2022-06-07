import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class CategoryFeedCacheManager extends BaseCacheManager {
  static final key = 'categoryFeedCacheManager';
  String _url;

  String get url => _url;
  
  CategoryFeedCacheManager() : 
    super(key,
      maxAgeCacheObject: CACHE_DURATION,
      maxNrOfCacheObjects: MAX_CACHE_OBJECTS,
    );

  @override
  Future<String> getFilePath() async {
    var dir = await getApplicationDocumentsDirectory();
    _url = join(dir.path, key);
    return _url;
  }

}