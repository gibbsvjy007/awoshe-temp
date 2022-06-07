import 'package:Awoshe/logic/api/search_api.dart';
import 'package:Awoshe/logic/api/search_db_provider.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/search/search_result_item.dart';
import 'package:mobx/mobx.dart';

import '../../../constants.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  @observable
  bool loading = false;

  @observable
  bool searchFinished = true;

  final List<SearchResultItem> recentSearchedItem = [];

  @observable
  ObservableList<SearchResultItem> searchResults = ObservableList<SearchResultItem>();

  @observable
  SearchType currentType = SearchType.ALL;

  @computed
  SearchType get currentSearchType => currentType;

  @action
  Future<void> initUserSearch() async {
    loading = true;
    final List<SearchResultItem> itemsFromLocalDB = await SearchDbProvider.db.fetchRecentSearch();
    recentSearchedItem.addAll(itemsFromLocalDB);
    loading = false;
  }

  @action
  Future<void> setSearchType(SearchType type) async {
    print(type);
    currentType = type;
  }

  @action
  Future<void> startSearching({String query}) async {
    searchFinished = false;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    loading = true;
    try {
      final RestServiceResponse res =
      await SearchApi.searchItems(searchQuery: query, searchType: currentType);
      if (res.content != null) {
        List<SearchResultItem> items = res.content.map<SearchResultItem>((i) {
          return SearchResultItem.fromJson(i);
        }).toList();
        searchResults.clear();
        searchResults.addAll(items);
      }
      searchFinished = true;
      loading = false;
    } catch(e) {
      searchFinished = true;
      loading = false;
    }
  }
}
