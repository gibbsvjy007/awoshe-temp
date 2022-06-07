import 'package:Awoshe/logic/stores/cache/cache_stores/CategoryFeedCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/CurrencyCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/FeedCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/ProductCacheStore.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/UserDetailsCacheStore.dart';


/// This Store class provide access to all cache managers store available.
/// It's just a access point over all app.
class CacheManagerStore {

  /// Holds cache data about currencys
  final CurrencyCacheStore currencyCacheStore = CurrencyCacheStore.instance;
  final UserDetailsCacheStore userDetailsCacheStore = UserDetailsCacheStore.instance;
  final FeedCacheStore feedCacheStore = FeedCacheStore.instance;
  final CategoryFeedCacheStore categoryFeedCacheStore = CategoryFeedCacheStore.instance;
  final ProductCacheStore productCacheStore = ProductCacheStore.instance;
  
  /// Clear all application cache.
  void clearApplicationCache(){
    currencyCacheStore.clear();
    userDetailsCacheStore.clear();
    feedCacheStore.clear();
    categoryFeedCacheStore.clear();
    productCacheStore.clear();
  }
  

}