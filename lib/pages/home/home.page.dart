import 'package:Awoshe/components/NewFeedAvailableWidget.dart';
import 'package:Awoshe/components/awsliverappbar.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/widgets/home/banner_view.dart';
import 'package:Awoshe/widgets/home/feed_widget.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/sliver_infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {


  ScrollController _scrollController;
  UserStore userStore;
  FeedsStore feedsStore;
  bool _fetchingMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    feedsStore = Provider.of<FeedsStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
    _scrollController = ScrollController();
    if (feedsStore.feeds.isEmpty) {
      initialize();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
    feedsStore?.unSubscribeToFeeds();
    userStore?.unSubscribeToMessageCount();
  }

  Future<void> initialize() async {
    await feedsStore.fetchFeeds(userStore.details.id);
    feedsStore.subscribeToFeeds();
    userStore.subscribeToMessageCount();
  }


  Widget newFeedsIndicator() => Observer(
      name: 'new_feed_available',
      builder: (context){
        print("new feeds available: " + feedsStore.newFeedAvailable.toString());
        if (feedsStore.newFeedAvailable)
          return NewFeedAvailableWidget(
            title: Localization.of(context).newFeedsAvailable,
            onTap: () async {
              await feedsStore.fetchLatest(userStore.details.id);
              _scrollController?.animateTo(0, duration: Duration(seconds: 2), curve: Curves.ease);
            },
          );
        return Container();
      }
  );

  void _onEndReached() async {
    if (feedsStore.allFeedsFetched) return;
    print("On End Reached");
    if (!_fetchingMore) {
      if (!feedsStore.loading && feedsStore.feeds.isEmpty) return;
      _fetchingMore = true;
      await feedsStore.fetchFeeds(userStore.details.id);
      _fetchingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('Home Page Build');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
//      appBar: feedsStore.loading || feedsStore.feeds.isEmpty ? AwosheAppBar(title: "Explore",) : null,
      body: Stack(
        children: <Widget>[
          RefreshIndicator(
            child: Observer(
              name: 'feeds',
              builder:(BuildContext context) {
                print("Home Page Build is Called");
                final feeds = feedsStore.feeds;

                if (!feedsStore.loading && feedsStore.feeds.isEmpty) {
                  return NoDataAvailable();
                }
//                  print("Loading feeds");
//
//                  if (feedsStore.loading && !_fetchingMore) {
//                    return AwosheLoadingV2();
//                  }
                return Container(
                  constraints: BoxConstraints.expand(),
                  child: SliverInfiniteListView(
                    scrollController: _scrollController,
                    onEndReached: _onEndReached,
                    endOffset: 100.0,
                    appbar: AwosheSliverAppBar(
                      showSearch: userStore.details.isDesigner,
                    ),
                    slivers: <Widget>[
                      BannerView(userStore: userStore, feedList: feedsStore.bannerFeeds,),

                      // fake feed widgets
                      if (feeds == null || feeds.isEmpty)
                        for(int i = 0; i < 3; i++)
                          Container(
                            width: 350,
                            height: 450,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                shimmerLoader(
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      width: 350,
                                      height: 40,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),

                                shimmerLoader(
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Container(
                                      width: 350,
                                      height: 290,
                                      color: primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                      else
                        for (Feed feed in feeds)
                          FeedWidget(feed: feed),

                      // now its just pagination widget

                      if (!feedsStore.allFeedsFetched)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                          child: AwosheLoadingV2(),
                        ),

                      if (feedsStore.allFeedsFetched)
                        Center(
                          key: UniqueKey(),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text('You\'ve reached the end!',
                                style: Theme.of(context).textTheme.title.copyWith(color: awLightColor)),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            onRefresh: () {
              return feedsStore.refreshFeeds(userStore.details.id);
            },
          ),
          Align(
            child: Container(
              child: newFeedsIndicator(),
              width: 200.0,
            ),
            alignment: Alignment(0 , -0.87),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}