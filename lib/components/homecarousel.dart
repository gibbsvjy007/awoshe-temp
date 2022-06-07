import 'package:Awoshe/components/useravatar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import 'package:flutter_svg/svg.dart';

class HomeCarousel extends StatefulWidget {
  final List<dynamic> feeds;
  HomeCarousel({this.feeds});

  @override
  HomeCarouselState createState() {
    return new HomeCarouselState();
  }
}

class HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 440.0,
          child: PageView.builder(
            pageSnapping: true,
            itemCount: carouselDemoCards.length,
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.96),
            itemBuilder: (BuildContext context, int itemIndex) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: <Widget>[
                    HomeCarouselCards(carouselDemoCards[itemIndex]),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class HomeCarouselCards extends StatefulWidget {
  final HomeCarouselCardModel cardViewModel;

  HomeCarouselCards(this.cardViewModel);

  @override
  HomeCarouselCardsState createState() {
    return new HomeCarouselCardsState(cardViewModel);
  }
}

class HomeCarouselCardsState extends State<HomeCarouselCards> {
  void _openAddProductDialog() {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'ProductPage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => ProductPage(),
      ),
    );
  }

  HomeCarouselCardModel cardViewModel;

  HomeCarouselCardsState(HomeCarouselCardModel cardViewModel) {
    this.cardViewModel = cardViewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      elevation: 0.1,
      child: Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                //child: new ClipRRect(
                //borderRadius: BorderRadius.circular(10.0),
                child: GestureDetector(
                  onTap: () {
                    _openAddProductDialog();
                  },
                  child:
                      //tag: "cardViewModel.productImageUrl",
                      Container(
                          //height: MediaQuery.of(context).size.width * (1 / (1.91/1)),
                          height: 300.0,
                          //width:MediaQuery.of(context).size.width * 0.9,
                          color: awLightColor,
                          padding: EdgeInsets.all(0.0),
                          child: TransitionToImage(
                            image: AdvancedNetworkImage(
                              cardViewModel.productImageUrl,
                              useDiskCache: true,
                              cacheRule: IMAGE_CACHE_RULE,
                            ),
                            fit: BoxFit.cover,
                            loadingWidget: Container(
                              color: Colors.grey,
                              height: 300.0,
                              width: double.infinity,
                            ),
                            height: 300.0,
                          )),
                ),
              ),
              new Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          UserAvatar(
                            userId: cardViewModel.uid,
                            designerProfileImgUrl:
                                cardViewModel.designerImageUrl,
                            designerRating:
                                cardViewModel.designerRating.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) =>
                                PublicProfilePage(profileUserId: cardViewModel.uid)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Designed by:",
                              style: TextStyle(
                                color: awLightColor,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            new Text(
                              cardViewModel.designername,
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: new IconButton(
                                    icon: SvgPicture.asset(
                                      Assets.share,
                                      color: secondaryColor,
                                      width: 23.0,
                                    ),
                                    onPressed: () {
                                    },
                                  ))
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: new IconButton(
                                    icon: SvgPicture.asset(
                                      Assets.heart,
                                      color: secondaryColor,
                                      height: 22.0,
                                    ),
                                    onPressed: () {
                                    },
                                  ))
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              Container(
                                //width: 24.0,
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 0.0),
                                    child: new IconButton(
                                      icon: SvgPicture.asset(
                                        Assets.shoppingbag,
                                        color: secondaryColor,
                                        height: 22.0,
                                      ),
                                      onPressed: () {
                                      },
                                    )),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, bottom: 18.0),
                          child: new Text(
                            cardViewModel.productTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            bottom: 16.0,
                          ),
                          child: new Text(
                            cardViewModel.productDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: awLightColor,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HomeCarouselCardModel {
  final String productImageUrl;
  final String designerImageUrl;
  final double designerRating;
  final String designername;
  final String productTitle;
  final String productDescription;
  final String uid;
  HomeCarouselCardModel({
    this.uid,
    this.productImageUrl,
    this.designerImageUrl,
    this.designerRating,
    this.designername,
    this.productTitle,
    this.productDescription,
  });
}

final List<HomeCarouselCardModel> carouselDemoCards = [
  new HomeCarouselCardModel(
    uid: "pymXiEnEYiQSCYT2LyHpAnlqODe2",
    productImageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/African_Fashion_in_the_City_4.JPG/1280px-African_Fashion_in_the_City_4.JPG",
    designerImageUrl:
        "https://i.pinimg.com/736x/3f/a1/52/3fa152d1766ddc861fe02b683a0292b0--african-men-fashion-africa-fashion.jpg",
    designerRating: 4.1,
    designername: "Vitali Adasi",
    productTitle: "Broken-in short-sleeve pocket polo shirt",
    productDescription:
        "Specially washed for softness and a broken-in appearance, this  looks and feels like the well-made... more ",
  ),
  new HomeCarouselCardModel(
    uid: "pymXiEnEYiQSCYT2LyHpAnlqODe2",
    productImageUrl:
        "https://i.pinimg.com/736x/3f/a1/52/3fa152d1766ddc861fe02b683a0292b0--african-men-fashion-africa-fashion.jpg",
    designerImageUrl:
        "https://i.pinimg.com/736x/3f/a1/52/3fa152d1766ddc861fe02b683a0292b0--african-men-fashion-africa-fashion.jpg",
    designerRating: 4.0,
    designername: "Vitali Adasi",
    productTitle: "Broken-in long-sleeve pocket polo shirt",
    productDescription:
        "Specially washed for softness and a broken-in appearance, this  looks and feels like the well-made... more ",
  ),
  new HomeCarouselCardModel(
    uid: "pymXiEnEYiQSCYT2LyHpAnlqODe2",
    productImageUrl:
        "https://i.pinimg.com/originals/a0/81/f1/a081f1e67efb5794c3c7e2c25e1b5a0b.jpg",
    designerImageUrl:
        "https://cdn.shopify.com/s/files/1/1503/3218/products/EzyWatermark180116104836136-1368x2052_1080x.png",
    designerRating: 4.2,
    designername: "Vitali Adasi",
    productTitle: "Broken-in Kaba Casual",
    productDescription:
        "Specially washed for softness and a broken-in appearance, this  looks and feels like the well-made... more ",
  ),
  new HomeCarouselCardModel(
    uid: "pymXiEnEYiQSCYT2LyHpAnlqODe2",
    productImageUrl:
        "https://cdn.shopify.com/s/files/1/1503/3218/products/EzyWatermark180116104836136-1368x2052_1080x.png",
    designerImageUrl:
        "https://i.pinimg.com/originals/a0/81/f1/a081f1e67efb5794c3c7e2c25e1b5a0b.jpg",
    designerRating: 4.8,
    designername: "Vitali BAAKO",
    productTitle: "Broken-in Kaba Casual",
    productDescription:
        "Specially washed for softness and a broken-in appearance, this  looks and feels like the well-made... more ",
  ),
  new HomeCarouselCardModel(
    uid: "pymXiEnEYiQSCYT2LyHpAnlqODe2",
    productImageUrl:
        "https://images.pexels.com/photos/326167/pexels-photo-326167.jpeg",
    designerImageUrl:
        "https://i.pinimg.com/originals/a0/81/f1/a081f1e67efb5794c3c7e2c25e1b5a0b.jpg",
    designerRating: 4.8,
    designername: "Vitali BAAKO",
    productTitle: "Broken-in Kaba Casual",
    productDescription:
        "Specially washed for softness and a broken-in appearance, this  looks and feels like the well-made... more ",
  )
];
