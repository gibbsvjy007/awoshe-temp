import 'package:Awoshe/components/closefab.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AwosheSubscriptionWebPage extends StatefulWidget {
  final String url;

  const AwosheSubscriptionWebPage({Key key, @required this.url})
      : super(key: key);

  @override
  _AwosheSubscriptionWebPageState createState() =>
      _AwosheSubscriptionWebPageState();
}

class _AwosheSubscriptionWebPageState extends State<AwosheSubscriptionWebPage> {


  @override
  Widget build(BuildContext context) {
    //var uid = Provider.of<UserStore>(context, ).details.id;

    return Scaffold(
      floatingActionButton: AwosheCloseFab( onPressed: () => Navigator.pop(context), ),

      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
        onWebViewCreated: (controller){
          //print(controller);
        },
      ),


//      body: InAppWebView(
//        initialUrl: widget.url,
//        initialHeaders: {'uid' : uid},
//
//        initialOptions: InAppWebViewWidgetOptions(
//          androidInAppWebViewOptions: AndroidInAppWebViewOptions(
//            allowUniversalAccessFromFileURLs: true,
//
//
//          ),
//            inAppWebViewOptions: InAppWebViewOptions(
//            debuggingEnabled: true,
//          )
//        ),
//      ),
    );
  }
}
