import 'package:Awoshe/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CurrencyCacheManager extends BaseCacheManager {
  String url;
  final String key;
  
  CurrencyCacheManager(this.key) : super(key,
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