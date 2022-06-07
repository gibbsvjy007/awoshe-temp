
import 'dart:async';

import 'package:Awoshe/logic/stores/cache/cache_stores/CurrencyCacheStore.dart';
import 'package:firebase_database/firebase_database.dart';

class CurrencyService {

  static const _CURRENCY_NODE = 'currencyconversions';

  Future<Map<dynamic, dynamic>> getCurrencyConversions() async {
    var cacheStore = CurrencyCacheStore.instance;

    try {
      var snapshot = await FirebaseDatabase.instance
          .reference().child(_CURRENCY_NODE).once()
          .timeout( Duration(seconds: 10), 
            onTimeout: ()  { throw TimeoutException('timeout'); } 
          );

      var map = snapshot.value;
      
      // storing currency in cache
      if (map != null || map.isNotEmpty){
        cacheStore.setData( map );
      }

      return map;
    }

    on TimeoutException catch (ex)  {
      return await cacheStore.getData();
    }

    catch (ex){
      print(ex);
      throw ex;
    }

  } 


}