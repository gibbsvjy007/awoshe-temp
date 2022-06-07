import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfileCacheManager extends BaseCacheManager {
  static final String _key = 'designerCacheManager';

  String _url;
  String get url => _url;

  ProfileCacheManager() : super(
    _key,
    maxAgeCacheObject: CACHE_DURATION,
    maxNrOfCacheObjects: MAX_CACHE_OBJECTS,
  );

  @override
  Future<String> getFilePath() async {
    var directory = await getApplicationDocumentsDirectory();
    _url = join(directory.path, _key);
    return _url;
  }

}