import 'package:Awoshe/components/category_heading.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import '../../constants.dart';

class ThumbnailView extends StatefulWidget {
  final Feed feed;
  ThumbnailView({this.feed});

  @override
  _ThumbnailViewState createState() => _ThumbnailViewState();
}

class _ThumbnailViewState extends State<ThumbnailView> {
  List colors = [awLightColor, awYellowColor, awDarkColor, primaryColor, secondaryColor];
  Random random = new Random();

  int index = 0;

  @override
  void initState(){

    super.initState();
    index = random.nextInt(3);
  }
  Widget buildThumbnailFeed(Map productData) {
    return productData != null ? GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<bool>(
            settings: RouteSettings(name: 'ProductPage'),
            fullscreenDialog: true,
            builder: (BuildContext context) => ProductPage(
              productId: productData['id'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 4.0, left: 8.0, right: 4.0),
        // image widget to be replaced
        child: TransitionToImage(
          loadingWidget: Container(
            height: MediaQuery.of(context).size.width * 0.5,
            color: awLightColor300,
          ),
          borderRadius: BorderRadius.circular(2.0),
          height: MediaQuery.of(context).size.width * 0.5,
          fit: BoxFit.cover,
          image: AdvancedNetworkImage(
            productData['imageUrl'] != null
                ? productData['imageUrl']
                : COVER_PLACEHOLDER,
            useDiskCache: true,
            cacheRule: IMAGE_CACHE_RULE,
          )
        ),
      ),
    ) : Container(
      margin: const EdgeInsets.only(
          top: 8.0, bottom: 4.0, left: 8.0, right: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        border: Border.all(width: 0.0,
        color: Colors.white)
      ),
      height: MediaQuery.of(context).size.width * 0.5,
      child: SvgPicture.asset(Assets.picture_th, color: colors[index], height: MediaQuery.of(context).size.width * 0.2, width: MediaQuery.of(context).size.width * 0.2,),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.feed != null) {
      List<dynamic> feeds = widget.feed.products;
      if (feeds != null && feeds.length > 0) {
        return Container(
          child: Column(
            children: <Widget>[
              CategoryHeader(
                heading: widget.feed.collection.title.toUpperCase(),
                isSeeAll: false,
              ),
              AwosheCard(
                margin: EdgeInsets.all(0.0),
                elevation: 0.0,
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: buildThumbnailFeed(feeds[0])),
                        Expanded(child: buildThumbnailFeed(feeds.length > 1 ? feeds[1] : null)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: buildThumbnailFeed(feeds.length > 2 ? feeds[2] : null)),
                        Expanded(child: buildThumbnailFeed(feeds.length > 3 ? feeds[3] : null)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        /*DesignerInfo(
                            designerId: widget.feed.creator.id,
                            designerImage: widget.feed.creator.thumbnailUrl,
                            designerName: widget.feed.creator.name,
                        ),*/
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 18.0, bottom: 18.0),
                          child: Text(
                            'Designed by ' + widget.feed.creator.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: awBlack),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 18.0,
                                  bottom: 16.0,
                                ),
                                child: Text(
                                  widget.feed.collection.description ?? "",
                                  maxLines: 2,
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
                )),
              ),
            ],
          ),
        );
      }
      return Container();
    }
  }
}
