import 'package:Awoshe/components/browser.dart';
import 'package:Awoshe/components/category_heading.dart';
import 'package:Awoshe/models/blog/blog.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/awoshe_card.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import '../../constants.dart';

class BlogView extends StatefulWidget {
  final Feed feed;

  BlogView({this.feed});

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  Blog blog;
  @override
  void initState() {
    super.initState();
    blog = Blog(
        id: widget.feed.id,
        url: widget.feed.url,
        imageUrl: widget.feed.imageUrl,
        title: widget.feed.title,
        feedType: widget.feed.type,
        creator: widget.feed.creator,
        description: widget.feed.description);
  }

  var browserLoader = Container(
    color: Colors.white,
    height: 15,
    width: 15,
    child: FlareActor(
      "assets/Awoshe.flr",
      alignment: Alignment.center,
      animation: 'Awoshe',
      fit: BoxFit.contain,
    ),
  ),
      doneLoader = Container(
    height: 15,
    width: 15,
    decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(7.5),
            topLeft: Radius.circular(7.5),
            bottomRight: Radius.circular(7.5),
            bottomLeft: Radius.circular(7.5))),
    child: CircleAvatar(
      backgroundColor: Colors.green,
      child: Icon(
        CupertinoIcons.check_mark_circled,
        size: 14,
      ),
    ),
  );

  //WebViewController _controller;
  var currentWeb = "";
  var url = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // _settingModalBottomSheet(context, blog.url);
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) =>
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ),
                    child: child,
                  ),
              transitionDuration: Duration(milliseconds: 800),
              pageBuilder: (BuildContext context, _, __) =>
                  AwosheBrowser(url: blog.url)));
        },
        child: Container(
          child: AwosheCard(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                CategoryHeader(
                  heading: "BLOG",
                  isSeeAll: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TransitionToImage(
                      loadingWidget: Container(
                        child: AwosheDotLoading(),
                        color: awLightColor300,
                        height: 250.0,
                        width: MediaQuery.of(context).size.width * 0.98,
                      ),
                      width: MediaQuery.of(context).size.width * 0.98,
                      height: 216.0,
                      fit: BoxFit.fitWidth,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            4.0,
                          ),
                          topRight: Radius.circular(4.0)),
                      image: AdvancedNetworkImage(
                        blog.imageUrl != null
                            ? blog.imageUrl
                            : COVER_PLACEHOLDER,
                        useDiskCache: true,
                        cacheRule: IMAGE_CACHE_RULE,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          blog.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        blog.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: awLightColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    )),
                    SizedBox(
                      height: 30.0,
                      child: Container(),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  // Widget _fakeDraggableWidget() => Container(
  //   height: 20,
  //   child: Center(
  //       child: Container(
  //         width: 40,
  //         height: 4,
  //         child: Divider(
  //           thickness: 2,
  //           color: Colors.grey,
  //         ),
  //       )
  //   ),
  // );

  // void _settingModalBottomSheet(context, url){
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc){
  //         return Container(
  //           padding:
  //           EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
  //           child: Stack(
  //             children: <Widget>[
  //               Container(
  //                 padding: EdgeInsets.only(top: 40, bottom: 30),
  //                 alignment: Alignment.topCenter,
  //                 height: MediaQuery.of(context).size.height * 1,
  //                 child: AnimatedContainer(
  //                   duration: Duration(seconds: 2),
  //                   curve: Curves.elasticIn,
  //                   color: Colors.grey,
  //                   child: WebView(
  //                     javascriptMode: JavascriptMode.unrestricted,
  //                     initialUrl: url,
  //                     onPageFinished: (String url) async{
  //                       var url = await _controller.currentUrl();
  //                       setState(() {
  //                         currentWeb = url;
  //                         browserLoader = doneLoader;
  //                       });
  //                     },
  //                     onWebViewCreated: (WebViewController webViewController) async {
  //                       _controller = webViewController;
  //                       //var ull = await _controller.currentUrl();

  //                       /* setState(() {

  //               });*/
  //                     },

  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.grey[100],
  //                     borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(10.0),
  //                         topLeft: Radius.circular(10.0))),
  //                 height: 40.0,
  //                 child: Stack(

  //                   children: <Widget>[
  //                     Align(
  //                       alignment:  Alignment.topLeft,

  //                       child: Padding(
  //                         padding: const EdgeInsets.only(left:8.0),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,

  //                           children: <Widget>[

  //                             Container(

  //                               decoration: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.only(
  //                                       topRight: Radius.circular(25.0),
  //                                       topLeft: Radius.circular(25.0),
  //                                       bottomRight: Radius.circular(25.0),
  //                                       bottomLeft: Radius.circular(25.0))),
  //                               height: 25,
  //                               width: 25,
  //                               //color: Colors.white,
  //                               child: Padding(
  //                                 padding: const EdgeInsets.all(5.0),
  //                                 child:browserLoader,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),

  //                     Align(
  //                       alignment: Alignment.topCenter,
  //                       child: InkWell(
  //                         onTap: (){

  //                           Navigator.pop(context);

  //                         },
  //                         onLongPress: (){

  //                           Navigator.pop(context);

  //                         },
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(top:2.0),
  //                           child: _fakeDraggableWidget(),
  //                         ),
  //                       ),
  //                     ),
  //                     AwosheCloseFabForBrowser(
  //                       diameter: 20.0,
  //                       onPressed: () => Navigator.pop(context),
  //                     ),
  //                   ],

  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Container(
  //                   //decoration:BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))),
  //                   padding: EdgeInsets.only(bottom: 0),
  //                   color: Colors.grey[100],
  //                   height: 30.0,
  //                   alignment: Alignment.bottomCenter,
  //                   child: Row(
  //                     children: <Widget>[
  //                       Column(
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 8.0),
  //                             child: Container(
  //                               width: MediaQuery.of(context).size.width * 0.6,
  //                               child: Text(
  //                                 currentWeb,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 softWrap: true,
  //                                 style: TextStyle(
  //                                   color: secondaryColor,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Expanded(
  //                         child: Container(),
  //                       ),

  //                       SizedBox(
  //                         width: 8,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }

}
