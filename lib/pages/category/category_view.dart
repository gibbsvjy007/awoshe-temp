import 'dart:async';
import 'package:Awoshe/logic/stores/category/category_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/home/feed_widget.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


/// render all the categories data here
/// by default ALL categories will be rendered
///
class CategoryView extends StatefulWidget {
  final String mainCategory;
  final String subCategory;
  CategoryView({this.mainCategory, this.subCategory, Key key}): super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with AutomaticKeepAliveClientMixin<CategoryView> {
  final ScrollController _scrollController = ScrollController();
  static const offsetVisibleThreshold = 50;
  CategoryStore categoryStore;
  UserStore userStore;
  bool _fetchingMore = false;



  Color _randomStatusColor = Colors.black;
  Color _randomNavigationColor = Colors.black;

  bool _useWhiteStatusBarForeground;
  //bool _useWhiteNavigationBarForeground;

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        _useWhiteStatusBarForeground = false;
        // _useWhiteNavigationBarForeground = true;
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        _useWhiteStatusBarForeground = false;
        //_useWhiteNavigationBarForeground = false;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }


  @override
  void initState() {
    print("Init Category View");
    print(widget.mainCategory.toLowerCase() +
        ' : ' +
        widget.subCategory.toString());
    categoryStore = CategoryStore();
    userStore = Provider.of<UserStore>(context, listen: false);
    categoryStore.fetchProductsPerPage = 0;
    initialize();
    super.initState();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void initialize() async {
    await categoryStore.fetchProductsByCategory(
        mainCategory: widget.mainCategory,
        subCategory: widget.subCategory ?? 'all',
        userId: userStore.details.id);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _onEndReached() async {
    if (categoryStore.allProductsFetched) return;
    print("On End Reached");
    if (!_fetchingMore) {
      if (!categoryStore.fetchingProducts && categoryStore.products.isEmpty)
        return;
      _fetchingMore = true;
      await categoryStore.fetchProductsByCategory();
      _fetchingMore = false;
    }
  }

  void onAfterBuild(BuildContext context) {
    // I can now safely get the dimensions based on the context
  }

  Widget topSixItems()=> Container(
    child:
    Padding(
        padding: const EdgeInsets.only(top:0.0),
        child:
        Container(
          padding: const EdgeInsets.only(bottom: 5.0),
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: awLightColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: awYellowColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: awDarkColor,
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://lorempixel.com/640/480/fashion"),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: awBlack,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        )
    ),
  );



  @override
  Widget build(BuildContext context) {
    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));



    return Scaffold(
      key: widget.key,
      backgroundColor: Colors.white,
      body: Observer(

        builder: (BuildContext context) {
          final feeds = categoryStore.products;

          if (categoryStore.fetchingProducts && !_fetchingMore) {
            return AwosheLoadingV2();
          }
          if (!categoryStore.fetchingProducts &&
              categoryStore.products.isEmpty) {
            return NoDataAvailable();
          }
          return Column(
            children: <Widget>[



              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 2));
                    //return categoryStore.refreshFeeds(userStore.details.id);
                  },
                  child: InfiniteListView(
                    scrollController: _scrollController,
                    onEndReached: _onEndReached,
                    endOffset: 100.0,
                    itemCount: feeds.length,
                    itemBuilder: (BuildContext context, int i) {
                      Feed feed = feeds[i];
                      if (i == feeds.length) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 15.0),
                          child: AwosheLoadingV2(),
                        );
                      } else {
                        return Column(
                          children: <Widget>[

                            FeedWidget(
                              feed: feed,
                              isSeeAll: false,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
