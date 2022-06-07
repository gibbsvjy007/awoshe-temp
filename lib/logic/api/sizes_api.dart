import 'package:http/http.dart' as http;
import 'dart:convert';

class SizesApi {

  static Future<String> getSizesJson() async {
    final URL = "https://awoshe.com/wp-content/category_size.json";
    
    try {
      var response = await http.get(URL,);
      if (  response.statusCode >= 200 && response.statusCode < 300)
        return response.body;
      else
        throw Exception(response.reasonPhrase);
    } 
    
    catch(ex){
      print('SizesApi::getSizesJson $ex');
      throw ex;

    }
  }

  

}

Map<String, dynamic> _parseSizeFileJson(String rawJson) {
  Map<String, dynamic> data = json.decode(rawJson);
  
}