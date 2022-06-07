import 'package:Awoshe/components/designer_widget.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/DynamicLinkUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/shared/action_button.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:basic_utils/basic_utils.dart';

class CategoryCard extends StatefulWidget {
  final Feed feed;
  final VoidCallback onFeedTap;
  
  CategoryCard({this.feed, this.onFeedTap});

  @override
  CategoryCardState createState() {
    return CategoryCardState();
  }
}

class CategoryCardState extends State<CategoryCard> {
  double instagramlikehide = 0.0;
  double threedots = 1.0;

  bool isMenuExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void _showProductDetail() {
    print("called page route");
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'ProductPage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => ProductPage(
          productId: widget.feed.id,
        ),
      ),
    );
  }

  void setExpandedMenu(bool flag) => isMenuExpanded = flag;

//  Widget designerWidget() => Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Stack(children: <Widget>[
//                UserAvatar(
//                  userId: widget.feed.creator.id,
//                  designerProfileImgUrl: widget.feed.creator.thumbnailUrl,
//                  fullName: widget.feed.creator.name,
//                  designerRating: "4.5",
//                )
//              ]),
//            ],
//          ),
//          Flexible(
//            flex: 1,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: GestureDetector(
//                onTap: (){
//                  print('clicked over ${widget.feed.creator.name}');
//                },
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      "Designed by:",
//                      style: TextStyle(
//                        color: awLightColor,
//                        fontSize: 10.0,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                    Text(
//                      widget.feed.creator.name,
//                      style: TextStyle(
//                        color: secondaryColor,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ],
//      );

  @override
  Widget build(BuildContext context) {
    final FeedsStore feedsStore =
    Provider.of<FeedsStore>(context, listen: false);
    //final Feed feed = Provider.of<Feed>(context, listen: false);
    final UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return AwosheCard(
        margin: EdgeInsets.all(0.0),
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            // product image
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: widget.onFeedTap ?? _showProductDetail,

                  child: Container(
                    color: awLightColor300,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(0.0),
                    constraints: BoxConstraints(
                      //minHeight: 350.0,
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: TransitionToImage(
                      image: AdvancedNetworkImage(
                        widget.feed.imageUrl != null
                            ? widget.feed.imageUrl
                            : COVER_PLACEHOLDER,
                        useDiskCache: true,
                        cacheRule: IMAGE_CACHE_RULE,
                        
                      ),
                      fit: BoxFit.cover,
                      placeholder: const Icon(Icons.refresh),
                      alignment: Alignment.centerRight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      enableRefresh: true,
                      loadingWidget: Container(
                        child: AwosheDotLoading(),
                        color: awLightColor300,
                        height: 50.0,
                        //width: double.infinity,
                      ),
                    ),
                  ),
                )
                //),
                ),

            // designer name section
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                GestureDetector(
                  onTap: _openCreatorProfilePage,
                  child: DesignerInfo(
                      designerId: widget.feed.creator.id,
                      designerImage: widget.feed.creator.thumbnailUrl,
                      designerName: widget.feed.creator.name),
                ),
                /*Flexible(
                  child: Container(
                    child: GestureDetector(
                      onTap: _openCreatorProfilePage,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                            left: 18.0,),
                        child: Text(
                          widget.feed.creator.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: awBlack
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/
                //Expanded(child: Container()),

                // expandable menu section
                Stack(
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.elasticIn,
                      opacity: instagramlikehide,

                      child: Row(
                        children: <Widget>[
                          // share button
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.share,
                              color: secondaryColor,
                              width: 23.0,
                            ),
                            onPressed: () async {
                              /// add share plugin
                              final RenderBox box = context.findRenderObject();
                              final link =
                              await DynamicLinkUtils.createProductLink(
                                  widget.feed.id, widget.feed.title, widget.feed.description, widget.feed.imageUrl, userStore.details.email)
                                  .buildUrl();

                              //final link = await parameters.buildUrl();
                              final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
                                link,
                                DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
                              );
                              final awShortUrl =  shortenedLink.shortUrl;

                              print('Link Created: ${awShortUrl..toString()}');
                              // link.
                              Share.share(awShortUrl.toString(),
                                  sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) &
                                  box.size);
                            },
                          ),
                          SizedBox(width: 5.0,),

                          // favourite button
                          Observer(
                            name: 'favourite_toggle',
                            builder: (BuildContext context) {
                              final bool isFavourited =
                                  widget.feed.isFavourited;
                              return AnimatedSwitcher(
                                child: ActionButton(
                                  key: Key(
                                      '${widget.feed.id}${widget.feed.isFavourited}'),
                                  width: 25.0,
                                  assetPath: isFavourited
                                      ? Assets.heartfilled
                                      : Assets.heart,
                                  svgColor: isFavourited
                                      ? Colors.red
                                      : secondaryColor,
                                  onTap: () {
                                    feedsStore.toggleFavourite(
                                        feed: widget.feed,
                                        userStore: userStore,
                                        userId: userStore.details.id);
                                  },
                                ),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      child: child,
                                      scale: animation
                                  );
                                },
                                duration: Duration(milliseconds: 300),
                              );
                            },
                          ),
                          SizedBox(width: 5.0,),

                          // shopping bag button
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.shoppingBag,
                              height: 24.0,
                              color: secondaryColor,
                            ),
                            onPressed: _showProductDetail,
                          ),
                        ],
                      ),
                    ),

                    (isMenuExpanded) ? Container() :
                    Positioned(
                      right: 0.0,
                      child: AnimatedOpacity(
                        opacity: threedots,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 201),
                        child: IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            size: 35.0,
                            color: awLightColor,
                          ),
                          onPressed: () {
                            setState(() {
                              setExpandedMenu(true);
                              if (instagramlikehide == 0.0) {
                                instagramlikehide = 1.0;
                                threedots = 0.0;
                                Future.delayed(const Duration(seconds: 10), () {
                                  setState(() {
                                    setExpandedMenu(false);
                                    // Here you can write your code for open new view
                                    if (instagramlikehide == 1.0) {
                                      instagramlikehide = 0.0;
                                      threedots = 1.0;
                                    }
                                  });
                                });
                              } else {
                                instagramlikehide = 0.0;
                                threedots = 1.0;

                                //... hellon
                              }
                            });
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),

            // feed title section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 53.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          StringUtils.capitalize(
                          widget.feed.title),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: awLightColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

  void _openCreatorProfilePage() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) =>
              PublicProfilePage(
                profileUserId: widget.feed.creator.id,
              )
      ),
    );
  }
}
