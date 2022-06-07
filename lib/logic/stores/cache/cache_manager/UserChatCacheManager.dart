import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Cache manager for user chats caching.
/// This cache manager holds what are the users that the current
/// application user has been talking recently.
class UserChatCacheManager extends BaseCacheManager {

  static final _key = 'userChatCacheManager';
  String _url;

  String get url => _url;

  UserChatCacheManager() :
        super(_key,
        maxAgeCacheObject: CACHE_DURATION,
        maxNrOfCacheObjects: MAX_CACHE_OBJECTS,);

  @override
  Future<String> getFilePath() async {
    var directory = await getApplicationDocumentsDirectory();
    _url = join(directory.path, _key);
    return _url;
  }

}