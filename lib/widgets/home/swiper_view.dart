import 'package:Awoshe/components/category_heading.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class SwiperView extends StatefulWidget {
  final Feed feed;
  final bloc;

  SwiperView({this.feed, this.bloc});

  @override
  _SwiperViewState createState() => _SwiperViewState();
}

class _SwiperViewState extends State<SwiperView> {
  double instagramlikehide = 0.0;
  double threedots = 1.0;

  Widget buildCarousel(List<dynamic> products) {
    double aspectRatio;
    String firstImageON = products[0]['orientation'];
    if (firstImageON == "p") {
      aspectRatio = 3 / 4.0;
    } else if (firstImageON == "l") {
      aspectRatio = 4 / 3;
    } else if (firstImageON == "Sq") {
      aspectRatio = 1;
    } else {
      aspectRatio = 1.91;
    }
    return Container(
      child: Center(
        child: CarouselSlider(
          enableInfiniteScroll: false,
          items: products.map<Widget>((productData) {
            return Container(
              decoration: BoxDecoration(
                //color: Colors.grey,
              ),
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              child: GestureDetector(
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
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 20.0),
                  //color: Color.fromRGBO(0, 0, 0, 20.0),
                  decoration: BoxDecoration(
                    //color: Color.fromRGBO(0, 0, 0, 0.03),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: new Offset(0.0, 0.0),
                          blurRadius: 15.0,
                          //spreadRadius: 7.0,
                        )
                      ]
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 5),
                  child: TransitionToImage(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    image: AdvancedNetworkImage(

                      productData['imageUrl'],
                      useDiskCache: true,
                      cacheRule: IMAGE_CACHE_RULE,
                    ),
                    fit: BoxFit.fitHeight,
                    placeholder: const Icon(Icons.refresh),
                    enableRefresh: true,
                    //color: Colors.grey,


                    loadingWidget: Container(
                      child: AwosheDotLoading(),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          viewportFraction: 0.85,

          aspectRatio: aspectRatio,
          autoPlay: false,
          onPageChanged: (index) {
          },
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> products = widget.feed.products;

    return Column(
      children: <Widget>[
        CategoryHeader(
          heading: widget.feed.collection != null ||
              widget.feed.collection.title != ""
              ? widget.feed.collection.title.toUpperCase()
              : "NEW SWIPER",
          isSeeAll: false,
        ),
        AwosheCard(
          margin: EdgeInsets.all(0.0),
          //color: ,

          elevation: 0.0,
          child: Column(
            children: <Widget>[

              if (products != null && products.length > 0)
                buildCarousel(products),
              Row(
                children: <Widget>[
                  /*DesignerInfo(
                      designerId: widget.feed.creator.id,
                      designerImage: widget.feed.creator.thumbnailUrl,
                      designerName: widget.feed.creator.name),*/
                  Expanded(child: Container()),
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
                        GestureDetector(
                          onTap: _openCreatorProfilePage,
                          child: Padding(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            widget.feed.collection.title,
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
          ),
        ),
      ],
    );
  }
}