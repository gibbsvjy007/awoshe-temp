import 'package:flutter/foundation.dart';

class AppCacheException implements Exception {
  
  final String message;

  AppCacheException({ @required this.message});

}