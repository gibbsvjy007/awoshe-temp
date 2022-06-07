import 'dart:io';

import 'package:Awoshe/components/video/awoshe_video_palyer.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/widgets/AwosheVideoPlayer.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class ProductCarousel extends StatefulWidget {
  //final Product product;
  final List<File> imageList;
  final String firstImageOrientation;
  final String videoUrl;
  //final String productId;

  //final ValueChanged<int> onDoubleTap;
  final ValueChanged<int> onTap;
  ProductCarousel( {this.firstImageOrientation,
    this.videoUrl,
    this.imageList, this.onTap});

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class _ProductCarouselState extends State<ProductCarousel> {
  final List<String> imgList = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/African_Fashion_in_the_City_4.JPG/1280px-African_Fashion_in_the_City_4.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/African_Fashion_in_the_City_5.JPG/1280px-African_Fashion_in_the_City_5.JPG',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/African_Fashion_in_the_City_4.JPG/1280px-African_Fashion_in_the_City_4.JPG',
  ];

  int _current = 0;


  defineAspectRatio() {
    var aspectRatio;
    //print('Product carrousel ${widget.product.images}');
    //print("here is the orientation");

    if (widget.firstImageOrientation == "p") {
      aspectRatio = 3.0 / 4.0;
    } else if (widget.firstImageOrientation == "l") {
      aspectRatio = 4.0 / 3.0;
    } else if (widget.firstImageOrientation == "Sq") {
      aspectRatio = 1.0;
    } else {
      aspectRatio = 1.91;
    }
    print(widget.firstImageOrientation);
    return aspectRatio;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var aspectRatio = defineAspectRatio();

    final carouselWidgets = widget.imageList.map<Widget>((image) {
      //print('Product carousel TAG: $image');

      bool remoteImage = image.path.contains('https:') || image.path.contains('http:');

      // widgets displayed by the carousel
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width*0.04),topLeft: Radius.circular(MediaQuery.of(context).size.width*0.04)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 0.0),
        child: GestureDetector(
          onTap:() {
            print('OnTap');
            if (widget.onTap != null)
              widget.onTap(_current);
          },
          /// new implementation of carousel widget with pinch
          child: PhotoView.customChild(
            child: TransitionToImage(
              image: (remoteImage) ? AdvancedNetworkImage(
                image.path,
                cacheRule: IMAGE_CACHE_RULE,
                useDiskCache: true,
              ) : FileImage(image),
              fit: BoxFit.fitHeight,
              borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width*0.04),topLeft: Radius.circular(MediaQuery.of(context).size.width*0.04)),

              placeholder: const Icon(Icons.refresh),
              enableRefresh: true,
              loadingWidget: Container(
                child: AwosheDotLoading(),
                //color: Color.fromRGBO(1,1,1,1.0),
                width: MediaQuery.of(context).size.width,
              ),
            ),

            tightMode: true,

          ),
        ),
        /// OLD IMPLEMENTATION of carousel child widget.
//                      child: GestureDetector(
//                        onTap: (widget.onTap == null) ? null : (){
//                          widget.onTap(_current);
//                        },
//                        onDoubleTap: () {
//                          if (widget.onDoubleTap != null)
//                            widget.onDoubleTap(_current);
//                        },
//
//                        child: TransitionToImage(
//                              image: (remoteImage) ? AdvancedNetworkImage(
//                                image.path,
//                                useDiskCache: true,
//                              ) : FileImage(image),
//                              fit: BoxFit.fitHeight,
//                          borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width*0.04),topLeft: Radius.circular(MediaQuery.of(context).size.width*0.04)),
//                              placeholder: const Icon(Icons.refresh),
//                              enableRefresh: true,
//                              loadingWidget: Container(
//                                child: AwosheDotLoading(),
//                                //color: Color.fromRGBO(1,1,1,1.0),
//                                width: MediaQuery.of(context).size.width,
//                              ),
//                        ),
//                      ),

      );
    }).toList();

    print('Product page => ${widget.videoUrl}');

    if ( widget.videoUrl != null  ){
      carouselWidgets.add(
          AwosheVideoPlayer(
              videoUrl: widget.videoUrl,
          ),
      );
    }
    return Column(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
               color: Colors.black
              ),
              child: Center(
                child: CarouselSlider(
                  items: carouselWidgets,// carousel widgets list
                  viewportFraction: 1.0,
                  //height: 240.0,
                  aspectRatio: aspectRatio,
                  enableInfiniteScroll:
                      (widget.imageList.length == 1) ? false : true,
                  autoPlay: false,
                  onPageChanged: (index) {
                    print(aspectRatio);
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),

            Positioned(
              //padding: EdgeInsets.symmetric(vertical: 0.0),
              //color: awLightColor,
              bottom: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DotsIndicator(
                    decorator: DotsDecorator(
                      activeColor: Colors.white,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                    dotsCount: carouselWidgets.length, //widget.imageList.length,
                    position: _current,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
