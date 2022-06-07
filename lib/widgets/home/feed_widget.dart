import 'package:Awoshe/components/category_card.dart';
import 'package:Awoshe/components/category_heading.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/widgets/home/blog_view.dart';
import 'package:Awoshe/widgets/home/swiper_view.dart';
import 'package:Awoshe/widgets/home/thumbnail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatelessWidget {
  final Feed feed;
  final bool isSeeAll;

  FeedWidget({this.feed, this.isSeeAll = true});

  @override
  Widget build(BuildContext context) {
    FeedsStore feedsStore = Provider.of<FeedsStore>(context, listen: false);

    return Provider<Feed>.value(
        value: feed,
        child: Column(
          children: <Widget>[
            if (feed.type == FeedType.BLOG) BlogView(feed: feed),
            if (feed.type == FeedType.TH) ThumbnailView(feed: feed),
            if (feed.type == FeedType.SW) SwiperView(feed: feed),
            if (feed.type == FeedType.SINGLE)
              Column(
                children: <Widget>[
                  CategoryHeader(
                    categoryName: feed.mainCategory,
                    // category: Utils.getCategoryByEnum(feed.mainCategory.toUpperCase()),
                    heading: feed.mainCategory.toUpperCase(),
                    feedsStore: feedsStore,
                    isSeeAll: isSeeAll,
                  ),
                  CategoryCard(feed: feed)
                ],
              )
          ],
        ));
  }

}
