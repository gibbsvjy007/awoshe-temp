import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ChatMessageCacheManager extends BaseCacheManager {

  static final _key = 'chatMessageCacheManager';
  String _url;
  String get url => _url;

  ChatMessageCacheManager() : super(_key,
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