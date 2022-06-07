import 'package:Awoshe/services/currency_service.dart';
import 'package:flutter/cupertino.dart';

class CurrencyStore  {

  final CurrencyService _service = CurrencyService();

  Map<dynamic, dynamic> currencyMap = Map();

  Future<void> init() async {
    var map = await _service.getCurrencyConversions();
    if (map == null || map.isEmpty)
      throw 'There is no currency values loaded';

    currencyMap = map;
    print(currencyMap.keys);
  }

  double getExchangeRate({@required String from, @required String to}) {
    var _from = from.toUpperCase();
    var _to = to?.toUpperCase() ?? _from;

    if (_from.compareTo(_to) == 0)
      return 1.0;

    // creating the key. An example is USD_GHS
    var key = '$_from\_$_to';
    return currencyMap[key][key];
  }


  double convertValue({
    @required double value,
    @required String from, @required String to}) {
    double exchangeRate = getExchangeRate(from: from, to: to);
    return value * exchangeRate;
  }

}