import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  void initState() {
    super.initState();
    fetchLinkData();
  }

  void fetchLinkData() async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
    var link = await FirebaseDynamicLinks.instance.getInitialLink();

    // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
    handleLinkData(link);

    // This will handle incoming links if the application is already opened
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      handleLinkData(dynamicLink);
    });
  }

  void handleLinkData(PendingDynamicLinkData data) {
    final Uri uri = data?.link;
    if(uri != null) {
      final queryParams = uri.queryParameters;
      if(queryParams.length > 0) {
        String userName = queryParams["username"];
        // verify the username is parsed correctly
        print("My users username is: $userName");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
      ),
      body: Center(
        child: Text("Test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dynamicLink = await createDynamicLink(userName: "Test");
          // dynamicLink has been generated. share it with others to use it accordingly.
          print("Dynamic Link: $dynamicLink");
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<Uri> createDynamicLink({@required String userName}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      uriPrefix: 'https://app.awoshe.com',
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse('https://app.awoshe.com/groupinvite?username=$userName'),
      androidParameters: AndroidParameters(
        packageName: 'com.awoshe.mobile.live',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.awoshe.mobile.live',
        minimumVersion: '1',
        appStoreId: '',
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl;
  }
}