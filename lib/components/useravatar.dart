import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/profile/public/public_profile_page.dart';
import 'package:Awoshe/pages/tabs/tabs.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:provider/provider.dart';

class UserAvatar extends StatefulWidget {
  final String userId;
  final String designerRating;
  final String designerProfileImgUrl;
  final String fullName;

  UserAvatar(
      {this.userId, @required this.designerProfileImgUrl, this.designerRating, this.fullName});

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {

  @override
  Widget build(BuildContext context) {
    final hasProfileImage = widget.designerProfileImgUrl?.isNotEmpty ?? false;
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    return Container(
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
        child: Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                /// do not navigate to public profile if the post is mine
                if (userStore.details.id == widget.userId) {
                  /// its me then simply navigate to profile tab
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx) => AwosheTabBar(
                                currrentPage: TabsPage.PROFILE,
                              )),
                      (_) => false);
                } else {
                  print('userID: ${widget.userId}');
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true,
                      settings: RouteSettings(isInitialRoute: true),
                      builder: (BuildContext context) => PublicProfilePage(profileUserId: widget.userId) ));
//                      builder: (BuildContext context) => PublicProfile(userId: widget.userId) ));
                }
              },
              child: hasProfileImage
                  ? CircleAvatar(
                      backgroundImage: AdvancedNetworkImage(
                        widget.designerProfileImgUrl,
                        cacheRule: IMAGE_CACHE_RULE,
                        useDiskCache: true,
                      ),
                      radius: 15.0,
                    )
                  : Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                          color: hasProfileImage ? Colors.transparent : awBlack,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(width: 2.0, color: Colors.white)),
                      child: Center(
                        child: Text(
                          Utils.getInitials(widget.fullName),
                          style: lightBoldText,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      // Here is the ratings Badge
      widget.userId != null
          ? Positioned(
              // draw a red marble
              top: 15.0,
              left: 7.5,
              child: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance.collection('users').document(widget.userId).snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    DocumentSnapshot ds = snapshot.data;
                    Color indicatorColor = Colors.grey;
                    Color borderColor = Colors.white;
                    if (snapshot.hasData && ds != null && ds.exists) {
                      if (ds.data['online'] != null && ds.data['online']) {
                        indicatorColor = Colors.green;
                        borderColor = Colors.white;
                      }
                    } else {
                     indicatorColor = Colors.grey;
                     borderColor = awYellowColor;
                    }
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1, color: borderColor),
                            color: indicatorColor),
                        child: Text(
                          //cardViewModel.designerRating.toString()
                          widget.designerRating,
                          style: TextStyle(
                              color: Colors.white, fontSize: 8.0, fontWeight: FontWeight.w600),
                        ));
                  }),
            )
          : Container(),
    ]));
  }
}
