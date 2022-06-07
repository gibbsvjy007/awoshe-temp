import 'package:Awoshe/components/closefabforbrowsers.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class AwosheBrowser extends StatefulWidget {
  AwosheBrowser({@required this.url  });

  final url;

  @override
  _AwosheBrowserState createState() => _AwosheBrowserState();
}

class _AwosheBrowserState extends State<AwosheBrowser> {
  static const DEFAULT_URL = "https://awoshe.com";
  WebViewController _controller;
  var currentWeb = "";

  Widget _fakeDraggableWidget() => Container(
    height: 20,
    child: Center(
        child: Container(
          width: 40,
          height: 4,
          child: Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        )
    ),
  );

  var browserLoader =  Container(
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
                     child: Icon(CupertinoIcons.check_mark_circled, size: 14,),

                  ),
                           );

//  void getCurrentUrl() async {
//    currentWeb = await _controller.currentUrl();
//    return null;
//  }
//
//  void _handleLoad(String value) {
//    setState(() async {
//      currentWeb = await _controller.currentUrl();
//      print(currentWeb);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    // var url;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.60),
      //floatingActionButton: AwosheCloseFab(bgColor: Colors.redAccent,),
      body: SafeArea(
        child:

        Container(
          padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * 1,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.elasticIn,
                  color: Colors.grey,
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url ?? DEFAULT_URL,
                    onPageFinished: (String url) async{
                      var url = await _controller.currentUrl();
                      setState(() {
                        currentWeb = url;
                        browserLoader = doneLoader;
                      });
                    },
                    onWebViewCreated: (WebViewController webViewController) async {
                      _controller = webViewController;
                      //var ull = await _controller.currentUrl();

                      /* setState(() {

                });*/
                    },

                    ),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0))),
                height: 40.0,
                child: Stack(

                  children: <Widget>[
                    Align(
                      alignment:  Alignment.topLeft,

                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[

                            Container(

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25.0),
                                      topLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0),
                                      bottomLeft: Radius.circular(25.0))),
                              height: 25,
                              width: 25,
                              //color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:browserLoader,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: (){

                            Navigator.pop(context);

                        },
                        onLongPress: (){

                          Navigator.pop(context);

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:2.0),
                          child: _fakeDraggableWidget(),
                        ),
                      ),
                    ),
                    AwosheCloseFabForBrowser(
                      diameter: 20.0,
                      onPressed: () => Navigator.pop(context),
                      ),
                  ],

                ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //decoration:BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))),
                  padding: EdgeInsets.only(bottom: 0),
                    color: Colors.grey[100],
                    height: 30.0,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  currentWeb,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                          ),
                        Expanded(
                          child: Container(),
                          ),

                        SizedBox(
                          width: 8,
                          )
                      ],
                      ),
                  ),
                )
            ],
            ),
          ),
      ),
    );
  }
}



/*
Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * 1,
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.elasticIn,
                  color: Colors.grey,
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url,
                    onPageFinished: (String url) async{
                      var url = await _controller.currentUrl();
                      setState(() {
                        currentWeb = url;
                        browserLoader = doneLoader;
                      });
                    },
                    onWebViewCreated: (WebViewController webViewController) async {
                   _controller = webViewController;
                   //var ull = await _controller.currentUrl();

               /* setState(() {

                });*/
                },

                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0))),
                height: 40.0,
                child: AwosheCloseFab(
                  bgColor: Colors.white,
                  diameter: 20.0,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //decoration:BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0))),
                  padding: EdgeInsets.only(bottom: 0),
                  color: secondaryColor,
                  height: 30.0,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                currentWeb,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  color: awLightColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25.0),
                                    topLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0))),
                            height: 25,
                            width: 25,
                            //color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:browserLoader,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
 */