import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/profile/followers/followers.page.dart';
import 'package:Awoshe/pages/profile/followings/followings.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageFollowingFollowers extends StatefulWidget {
  MessageFollowingFollowers({Key key}) : super(key: key);

  @override
  _MessageFollowingFollowersState createState() =>
      _MessageFollowingFollowersState();
}

class _MessageFollowingFollowersState extends State<MessageFollowingFollowers> {
  ProfileStore profileStore;
  UserStore userStore;

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    profileStore = ProfileStore();
    profileStore.setUserDetails(userStore.details);
  }


  Widget noFollowers() {
    String emptyText = "No Followings";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgIcon(Assets.emptyFollowers, size: 150.0),
          SizedBox(height: 20.0),
          Text(
            emptyText,
            style: TextStyle(fontSize: 18.0, color: awLightColor),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return userStore.details.isDesigner
        ? FollowersPage(profileStore: profileStore, showAppBar: false, wantToChat: true,)
        : FollowingsPage(profileStore: profileStore, showAppBar: false, wantToChat: true,);
  }
}
