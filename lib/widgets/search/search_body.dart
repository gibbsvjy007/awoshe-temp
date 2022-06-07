import 'package:Awoshe/logic/api/search_db_provider.dart';
import 'package:Awoshe/logic/stores/search/search_store.dart';
import 'package:Awoshe/models/search/search_result_item.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/search/product_item.dart';
import 'package:Awoshe/widgets/shared/search_result_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SearchBody extends StatefulWidget {
  final SearchStore searchStore;
  const SearchBody({Key key, this.searchStore}) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  void initState() {
    super.initState();

    if (searchStore.recentSearchedItem.isEmpty) {
      searchStore.initUserSearch();
    }
  }

  SearchStore get searchStore => widget.searchStore;

  Widget recentSearch() => Expanded(
    child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Recent searches',
                  style: textStyle1,
                ),
                SizedBox(height: 10.0),

              ]..addAll( searchStore.recentSearchedItem.map(
                      (item) => ProductItem(product: item, onPressed: () => onItemPressed(item)))
              ),
            ),
          ),
        ),
  );


  void onItemPressed(SearchResultItem item) async {
    await SearchDbProvider.db.addSearch(item);

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'ProductPage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => ProductPage(
          productId: item.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String _searchIinput = Provider.of<String>(context);

    return Observer(
        name: 'search_observer',
        builder: (BuildContext context) {
          bool loading = searchStore.loading;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0,),
              _searchIinput.isNotEmpty
                  // ? Container()
                  ? Expanded(
                      child: SearchResultsList(
                        loading: loading,
                        itemCount: searchStore.searchResults.length,
                        itemBuilder: (BuildContext c, int index) {
                          final SearchResultItem item = searchStore.searchResults[index];
                          return ProductItem(
                              product: item,
                              onPressed: () => onItemPressed(item));
                        },
                        noResultsWidget: searchStore.searchFinished &&
                                searchStore.searchResults.isEmpty
                            ? Center(child: Text('No result found'))
                            : Container(),
                      ),
                    )
                  : (!loading && searchStore.recentSearchedItem.isNotEmpty)
                      ? recentSearch()
                      : Container()
            ],
          );
          
        });
  }
}
