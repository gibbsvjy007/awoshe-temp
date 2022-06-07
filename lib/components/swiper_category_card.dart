import 'package:Awoshe/components/designer_widget.dart';
import 'package:Awoshe/components/useravatar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class SwiperCategoryCard extends StatefulWidget {
  final Map product;
  final bloc;
  SwiperCategoryCard(this.product, {this.bloc});

  @override
  SwiperCategoryCardState createState() {
    return SwiperCategoryCardState();
  }
}

class SwiperCategoryCardState extends State<SwiperCategoryCard> {
  double instagramlikehide = 0.0;

  double threedots = 1.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showProductDetail() {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        settings: RouteSettings(name: 'ProductPage'),
        fullscreenDialog: true,
        builder: (BuildContext context) => ProductPage(
          productId: widget.product['productId'],
        ),
      ),
    );
  }

  Widget designerWidget() => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(children: <Widget>[
            UserAvatar(
              userId: widget.product['designerId'],
              designerProfileImgUrl: widget.product['designerImageUrl'],
              fullName: widget.product['designerName'],
              //designerRating: designerData['rating'] ?? "4.5",
              designerRating: "4.5",
            )
          ]),
        ],
      ),
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Designed by:",
                style: TextStyle(
                  color: awLightColor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.product['designerName'],
                style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    print('swipecategorycard build');
    return AwosheCard(
      
        margin: EdgeInsets.all(0.0),
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {
                    _showProductDetail();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(0.0),
                    constraints: BoxConstraints(
                      //minHeight: 350.0,
                      maxHeight: 250.0,
//                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    // image widget to be replaced
                    child: TransitionToImage(
                        width: double.infinity,
                        image: AdvancedNetworkImage(
                          widget.product['firstProductImageUrl'] != null
                              ? widget.product['firstProductImageUrl']
                              : COVER_PLACEHOLDER,
                          useDiskCache: true,
                          cacheRule: IMAGE_CACHE_RULE,
                        ),


                      borderRadius: BorderRadius.only(topRight: Radius.circular(5.0), topLeft: Radius.circular(5.0)),
                        fit: BoxFit.cover,
                        placeholder: const Icon(Icons.refresh),
                        alignment: Alignment.centerRight,
                        enableRefresh: true,
                            loadingWidget: Container(
                              child: AwosheDotLoading(),
                              color: Colors.transparent,
                              height: 250.0,
                              //width: double.infinity,
                            ),
                      ),

                  ),
                )
              //),
            ),
            Row(
              children: <Widget>[
                DesignerInfo(
                    designerId: widget.product['designerId'],
                    designerImage: widget.product['designerImageUrl'],
                    designerName: widget.product['designerName']
                ),
                Expanded(child: Container()),
                Stack(
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.elasticIn,
                      opacity: instagramlikehide,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.share,
                              color: secondaryColor,
                              width: 23.0,
                            ),
                            onPressed: () {
                              /// TODO - share this product
                              /// add share plugin
                              final RenderBox box = context.findRenderObject();
                              Share.share(
                                  "https://avatars0.githubusercontent.com/u/40177664?s=400&v=4",
                                  sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) &
                                  box.size);
                            },
                          ),

                          /// favourite button
                          StreamBuilder<List<DocumentSnapshot>>(
                              stream: widget.bloc.getFavourites(),
                              builder: (context, snapshot) {
                                bool isFav = false;
                                if (snapshot.hasData &&
                                    snapshot.data != null &&
                                    snapshot.data.length > 0) {
                                  List<String> allIds = snapshot.data
                                      .map((DocumentSnapshot d) => d.documentID)
                                      .toList();
                                  if (allIds
                                      .contains(widget.product['productId'])) {
                                    
                                    isFav = true;
                                  }
                                }
                                return IconButton(
                                  icon: isFav
                                      ? SvgPicture.asset(
                                    Assets.heartfilled,
                                    color: Colors.red,
                                    height: 22.0,
                                  )
                                      : SvgPicture.asset(
                                    Assets.heart,
                                    height: 22.0,
                                    color: secondaryColor,
                                  ),
                                  onPressed: () {
                                    widget.bloc.updateFavourite(
                                        widget.product['productId']);
                                  },
                                );
                              }),
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
                    Positioned(
                      right: 0.0,
                      child: AnimatedOpacity(
                        opacity: threedots,
                        duration: Duration(milliseconds: 201),
                        child: IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: secondaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              if (instagramlikehide == 0.0) {
                                instagramlikehide = 1.0;
                                threedots = 0.0;
                                Future.delayed(const Duration(seconds: 5), () {
                                  setState(() {
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
                        padding:
                        const EdgeInsets.only(left: 18.0, bottom: 18.0),
                        child: Text(
                          widget.product['productTitle'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          widget.product['productDescription'],
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
        ));
  }
}
