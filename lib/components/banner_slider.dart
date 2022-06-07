import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class BannerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            offset: new Offset(0.0, -2.0),
            blurRadius: 7.0,
            //spreadRadius: 7.0,
          )
        ]),
        //alignment: Alignment.bottomCenter,
        child: Stack(
          children: <Widget>[
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "New and just for y-o-u,",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24.0,
                        fontFamily: 'Oswald',
                       // fontWeight: FontWeight.w600,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      "Vijay",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 24.0,
                        fontFamily: 'Oswald',
                        //fontWeight: FontWeight.w600,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0, bottom: 5.0),
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                //reverse: true,

                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Container(
                        width: 138.0,
                        height: 132.0,
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
                                          "https://i.pinimg.com/736x/3f/a1/52/3fa152d1766ddc861fe02b683a0292b0--african-men-fashion-africa-fashion.jpg",
                                          useDiskCache: true,
                                          cacheRule: IMAGE_CACHE_RULE,
                                        ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              "Women",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Container(
                        width: 138.0,
                        height: 132.0,
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
                                          "https://i.pinimg.com/originals/a0/81/f1/a081f1e67efb5794c3c7e2c25e1b5a0b.jpg",
                                          useDiskCache: true,
                                          cacheRule: IMAGE_CACHE_RULE,
                                          ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              "Kids",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Container(
                        width: 138.0,
                        height: 132.0,
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
                                          "https://cdn.shopify.com/s/files/1/1503/3218/products/EzyWatermark180116104836136-1368x2052_1080x.png",
                                          cacheRule: IMAGE_CACHE_RULE,
                                          useDiskCache: true,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
