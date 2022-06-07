import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/endpoints.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/utils.dart';

class SearchApi {

  static Future<RestServiceResponse> searchItems({String searchQuery, SearchType searchType}) async {
    Map<String, String> headerParams = Map<String, String>();
    print("Search Query: " + searchQuery);

    Map<String, String> queryParams = {
      "page": '0', 
      "limit": '20', 
      "type": Utils.getSearchType(searchType),
      "search": searchQuery};
    
    RestServiceResponse response = await restClient.getAsyncV2(
      resourcePath: EndPoints.PRODUCT,
      headerParams: headerParams,
      queryParams: queryParams
    );

    if (!response.success) throw Exception(response.message);
    return response;
  }
}