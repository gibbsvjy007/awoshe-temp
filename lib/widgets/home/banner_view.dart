import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../constants.dart';

class BannerView extends StatelessWidget {
  final ObservableList<Feed> feedList;
  final UserStore userStore;

  BannerView({this.feedList, this.userStore});

  // width, name, imageUrl,
  @override
  Widget build(BuildContext context) {
    print('banner view widget');

    final widget = Observer(
      builder: (context) {
        var isLoading = (feedList == null || feedList.length == 0);
        print('is Loading $isLoading');

//        isLoading = true;
        return Container(
          margin: const EdgeInsets.only(top: 20.0),
          padding: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.0),
              offset: new Offset(0.0, 1.0),
              blurRadius: 15.0,
            ),
          ]),
          child: Stack(
            children: <Widget>[
              // header
              _buildHeaderSection(context, loading: isLoading),

              Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
                height: 220.0,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _listViewItems(context, isLoading: isLoading)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

    return widget;

    // keeping the old code for now!

//    return feedList != null && feedList.length > 0
//        ? Container(
//            padding: EdgeInsets.only(top: 2),
//            decoration: BoxDecoration(color: Colors.red, boxShadow: [
//              BoxShadow(
//                color: Color.fromRGBO(0, 0, 0, 0.04),
//                offset: new Offset(0.0, -2.0),
//                blurRadius: 7.0,
//              )
//            ]),
//            child: Stack(
//              children: <Widget>[
//                Container(
//                  height: 50.0,
//                  width: MediaQuery.of(context).size.width,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 8.0, horizontal: 20.0),
//                    child: Wrap(
//                      children: <Widget>[
//                        Text(
//                          "New and just for y-o-u,",
//                          overflow: TextOverflow.ellipsis,
//                          style: TextStyle(
//                            color: primaryColor,
//                            fontSize: 22.0,
//                            fontFamily: 'Oswald',
//                            //fontWeight: FontWeight.w400,
//                          ),
//                          maxLines: 1,
//                        ),
//                        Text(
//                          " " + userStore.details?.name,
//                          style: TextStyle(
//                            color: primaryColor,
//                            fontSize: 22.0,
//                            fontFamily: 'Oswald',
//                            //fontWeight: FontWeight.w400,
//                          ),
//                          overflow: TextOverflow.ellipsis,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                Container(
//                  padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
//                  height: 220.0,
//                  child: ListView(
//                    // This next line does the trick.
//                    scrollDirection: Axis.horizontal,
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.all(8.0),
//                          ),
//                          for (Feed feed in feedList)
//                            GestureDetector(
//                              onTap: () {
//                                Navigator.of(context, rootNavigator: true).push(
//                                  CupertinoPageRoute<bool>(
//                                    fullscreenDialog: true,
//                                    builder: (BuildContext context) =>
//                                        ProductPage(productId: feed.id),
//                                  ),
//                                );
//                              },
//                              child: Container(
//                                width: MediaQuery.of(context).size.width * 0.29,
//                                height: 132.0,
//                                margin: EdgeInsets.only(
//                                    right: MediaQuery.of(context).size.width *
//                                        0.1 /
//                                        5),
//                                decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(2.0),
//                                    boxShadow: [
//                                      BoxShadow(
//                                        color: Color.fromRGBO(0, 0, 0, 0.04),
//                                        offset: new Offset(0.0, 2.0),
//                                        blurRadius: 7.0,
//                                        //spreadRadius: 7.0,
//                                      )
//                                    ]),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Container(
//                                      padding: EdgeInsets.all(0.0),
//                                      height: 86.0,
//                                      decoration: BoxDecoration(
//                                          borderRadius: BorderRadius.only(
//                                            topRight: Radius.circular(3.0),
//                                            topLeft: Radius.circular(3.0),
//                                          ),
//                                          image: DecorationImage(
//                                              image: AdvancedNetworkImage(
//                                                  feed.imageUrl ??
//                                                      PLACEHOLDER_DESIGN_IMAGE,
//                                                  useDiskCache: true),
//                                              fit: BoxFit.cover)),
//                                    ),
//                                    Text(
//                                      StringUtils.capitalize(feed.mainCategory),
//                                      style: TextStyle(
//                                          color: secondaryColor,
//                                          fontWeight: FontWeight.w400,
//                                          fontSize: 16.0),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ),
//                          Padding(
//                            padding: EdgeInsets.all(10.0),
//                          ),
//                        ],
//                      )
//                    ],
//                  ),
//                )
//              ],
//            ))
//        : Container();
  }

  Widget _buildHeaderSection(BuildContext context, {bool loading = false}) =>
      (loading)
          ?


        Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0)),
            ),
            margin: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 20.0),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 40,


        )
      
          :
      Container(
        height: 50.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: (loading) ? Container() : Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 20.0),
          child: Wrap(
            children: <Widget>[

              /*Text(
                " " + userStore.details?.name,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 22.0,
                  fontFamily: 'Oswald',
                  //fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),*/
              Text(
                "Modern ethical African fashion",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      );

  Widget _listViewItems(BuildContext context, {bool isLoading}) =>
      Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
          ),

          if(isLoading)
            for(var i = 0; i < 3; i++)
              _buildFeedItem(Feed.empty, context, isLoading: isLoading)

          else
            for (Feed feed in feedList)
              _buildFeedItem(feed, context, isLoading: isLoading),

          Padding(
            padding: EdgeInsets.all(10.0),
          ),
        ],
      );

  Widget _buildFeedItem(Feed feed, BuildContext context,
      {bool isLoading = false}) {
    final widget = GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<bool>(
            settings: RouteSettings(name: 'ProductPage'),
            fullscreenDialog: true,
            builder: (BuildContext context) =>
                ProductPage(productId: feed.id),
          ),
        );
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.29,
        height: 132.0,
        margin: EdgeInsets.only(
            right: MediaQuery
                .of(context)
                .size
                .width * 0.1 / 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: new Offset(0.0, 2.0),
                blurRadius: 7.0,
                //spreadRadius: 7.0,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (isLoading) ? shimmerLoader(
                Container(
                  padding: EdgeInsets.all(0.0), height: 86.0,)
            ) :
            Container(
              padding: EdgeInsets.all(0.0),
              height: 86.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3.0),
                    topLeft: Radius.circular(3.0),
                  ),
                  image: DecorationImage(
                      image: AdvancedNetworkImage(
                          feed.imageUrl ??
                              PLACEHOLDER_DESIGN_IMAGE,
                          useDiskCache: true,
                          cacheRule: IMAGE_CACHE_RULE,
                        ),

                      fit: BoxFit.cover)),
            ),

            Text(
              StringUtils.capitalize(feed.mainCategory ?? 'SHIMMER'),
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0
              ),
            )
          ],
        ),
      ),
    );

    return isLoading ? widget : widget;
  }
}

