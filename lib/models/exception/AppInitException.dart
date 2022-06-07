import 'package:flutter/foundation.dart';

enum AppInitError {
  NO_INTERNET, 
  APP_VERSION_ERROR, 
  LOCAL_DB_ERROR,
  NO_DATA_CACHE_ERROR,
  ERROR
}

class AppInitException implements Exception {
  final AppInitError type;
  final String message;

  AppInitException({@required this.type,  @required this.message});

}