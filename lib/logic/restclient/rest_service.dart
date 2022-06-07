
import 'package:Awoshe/logic/restclient/restclient.dart';

abstract class RestService {
  RestClient rest;
  RestService(this.rest);
}
