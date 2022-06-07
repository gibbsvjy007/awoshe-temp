import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class UserDetailsCacheManager extends BaseCacheManager {
  static final key = 'userCacheManager';
  String url;
  
  UserDetailsCacheManager() : super(key,
    maxAgeCacheObject: CACHE_DURATION,
    maxNrOfCacheObjects: 1,
  );

  @override
  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    url = join(directory.path, key);
    return url;
  }

}