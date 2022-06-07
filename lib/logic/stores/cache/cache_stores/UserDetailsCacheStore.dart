import 'package:Awoshe/logic/stores/cache/cache_manager/UserDetailsCacheManager.dart';
import 'package:Awoshe/models/exception/AppCacheException.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'dart:convert';

// Singleton class which provide acces to UserCacheManager instance
class UserDetailsCacheStore {
  
  static final UserDetailsCacheStore _instance = UserDetailsCacheStore._private();
  static UserDetailsCacheStore get instance => _instance;

  final UserDetailsCacheManager _manager = UserDetailsCacheManager();

  UserDetailsCacheStore._private();

  Future<UserDetails> getData() async {

    try {

      if (_manager.url == null)
        await _manager.getFilePath();

      var fileInfo = await _manager.getFileFromCache(_manager.url, );
      var bytes = fileInfo.file.readAsBytesSync();
      var jsonData = Map<String, dynamic>.from( json.decode( utf8.decode(bytes) ) );

      if (jsonData == null || jsonData.isEmpty)
        AppCacheException(message: 'No user data cache');
        
      return UserDetails.fromJson(jsonData);

    } 
    catch(ex){
      print('UserDetailsCacheStore::getData $ex');
      throw ex;
    }
  }

  void setData(UserDetails data) {
    try {
      var map = data.toJson();
      var jsonString = json.encode( map );
      var bytes = utf8.encode( jsonString );
      print('saving userDetails in ${_manager.url}');;
      _manager.putFile(_manager.url, bytes, eTag: data.id, fileExtension: 'cache');
    } 
    catch (ex){
      print('UserDetailsCacheStore::setData $ex');
      throw ex;
    }
    
  }

  void clear() {
    _manager.emptyCache();
  }
  
}