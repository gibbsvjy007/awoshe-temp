import 'package:Awoshe/constants.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProductCacheManager extends BaseCacheManager {
  static final String key = 'productCacheManager';
  String _url;

  String get url => _url;

  ProductCacheManager() : super(key,
    maxAgeCacheObject: CACHE_DURATION,
    maxNrOfCacheObjects: MAX_CACHE_OBJECTS,
  ) ;

  @override
  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    _url = join(directory.path, key);
    return _url;
  }

}