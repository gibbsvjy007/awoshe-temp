import 'dart:async';

import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/search/search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:Awoshe/components/awcupertinotextfield.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_transform/stream_transform.dart';
import 'search_body.dart';

class SearchForm extends StatefulWidget {
  final SearchStore searchStore;
  const SearchForm({Key key, this.searchStore}) : super(key: key);

  @override
  SearchFormState createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm> {
  final TextEditingController _textController = TextEditingController();
  StreamController<String> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<String>.broadcast();

    _streamController.stream
        .transform(debounce(Duration(milliseconds: 600)))
        .listen(_searchDesignersOrProducts);
  }

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _textController?.dispose();
  }

  SearchStore get searchStore => widget.searchStore;

  void _searchDesignersOrProducts(String query) {
    searchStore.startSearching(query: query);
  }

  Widget searchForBlock() => Observer(
    name: 'search_type',
    builder: (_) {
      SearchType currentType = searchStore.currentSearchType;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(color: awLightColor),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          color: Colors.white,
          //margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //height: 180.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.0,),
              Text(
                'Search for',
                style: textStyle1,
              ),
              SizedBox(height: 2.0),
              Container(
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.only(left: 0.0),
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.DESIGNER);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                             currentType == SearchType.DESIGNER ? Assets.searchDesignerActive : Assets.designerSearch,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.MEN);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left:
                              MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                             currentType == SearchType.MEN ? Assets.searchMenActive : Assets.searchMan,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.WOMEN);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                             currentType == SearchType.WOMEN ? Assets.searchWomenActive : Assets.searchWoman,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.KIDS);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                             currentType == SearchType.KIDS ? Assets.searchChildrenActive : Assets.searchChildren,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.ACCESSORIES);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                             currentType == SearchType.ACCESSORIES ? Assets.searchAccessoriesActive : Assets.searchAccessories,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await searchStore.setSearchType(SearchType.HOME);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: SvgPicture.asset(
                            currentType == SearchType.HOME ? Assets.searchHomeActive : Assets.searchHome,
                            //height: 70.0,
                            width: MediaQuery.of(context).size.width * 0.143,
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      );
    }
  );


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: secondaryColor),
          centerTitle: false,
          title: AwosheCupertinoTextField(
              placeholder: "Search products",
              prefix: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  Assets.search,
                  width: 22.0,
                  color: secondaryColor,
                ),
              ),
              //placeholder: "  he",
              clearButtonMode: OverlayVisibilityMode.editing,
              onChanged: (text) {
                _streamController.add(text);
              }),
        ),
        searchForBlock(),
        Expanded(
          child: StreamProvider<String>.value(
              value: _streamController.stream,
              initialData: '',
              child: SearchBody(
                searchStore: widget.searchStore,
              )),
        )

      ],
    );
  }
}
