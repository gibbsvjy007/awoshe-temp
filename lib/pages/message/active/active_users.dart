import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ActiveUsers extends StatefulWidget {
  ActiveUsers({Key key})
      : super(key: key);

  @override
  _ActiveUsersState createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {


  Widget noActiveUsers() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0),
          SvgIcon(Assets.emptyChat, size: 150.0),
          SizedBox(height: 20.0),
          Text(
            "No Active User",
            style: TextStyle(fontSize: 18.0, color: awLightColor),
          )
        ],
      ),
    );
  }

//  Widget getActiveUsersFromConversation() {
//    return StreamBuilder(
//      stream: widget.messageBloc.conversations,
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        if (snapshot.connectionState == ConnectionState.waiting) {
//          return Center(child: CircularProgressIndicator());
//        } else {
//          if (snapshot.hasData &&
//              snapshot.data != null &&
//              snapshot.data.length > 0) {
//            print(snapshot.data[0].receiverName);
//            return Column(
//              children: snapshot.data
//                  .map<Widget>(
//                      (item) => buildItem(context, item.receiverId))
//                  .toList(),
//            );
//          } else {
//            return noActiveUsers();
//          }
//        }
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    // This is temporary. Because we're not using active user yet/
    // so (Marcos Boaventura) added this code.
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        noActiveUsers(),
      ],
    );

    // return SingleChildScrollView(
    //     controller: ScrollController(),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       //crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         //SizedBox(height: 1.0),
    //         noActiveUsers(),
//            Container(
//              width: double.infinity,
//              color: awLightColor,
//              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
//              child: SizedBox(
//                child: Text(
//                  AppData.isDesigner != null && AppData.isDesigner ? "Followers" : "Followings",
//                  style: TextStyle(color: secondaryColor),
//                ),
//                height: 20.0,
//              ),
//            ),
//            StreamBuilder(
//              stream: widget.messageBloc.followingFollowers,
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.waiting) {
//                  return Center(
//                    child: CircularProgressIndicator(
//                      strokeWidth: 1.0,
//                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                    ),
//                  );
//                } else {
//                  if (snapshot.hasData) {
//                    /// look for active users from the conversation list as
//                    /// well and merge with following followers online users
//                    ///
//                    return Column(
//                      children: snapshot.data
//                          .map<Widget>((item) => buildItem(context, item['target']))
//                          .toList(),
//                    );
//                  } else {
//                    return Container();
//                  }
//                }
//              },
//            ),
            // SizedBox(height: 10.0),
//            Container(
//              width: double.infinity,
//              color: awLightColor,
//              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
//              child: SizedBox(
//                child: Text(
//                  "Conversations",
//                  style: TextStyle(color: secondaryColor),
//                ),
//                height: 20.0,
//              ),
//            ),
//            getActiveUsersFromConversation()
        //   ],
        // ));
  }
}
