import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NUserFollow extends StatelessWidget {
  NUserFollow(
      {Key key,
      this.notification,
      this.userStore,
      this.friend,
      this.notificationStore})
      : super(key: key);

  final Notifications notification;
  final User friend;
  final UserStore userStore;
  final NotificationStore notificationStore;

  @override
  Widget build(BuildContext context) {
    final UserStore userStore = Provider.of<UserStore>(context, listen: false);
    print("user follow notification");
    Map<String, dynamic> actions = notification.content['actions'];
    return Observer(
      builder: (BuildContext context) {
        bool isFollowing = userStore.followingUserIds.contains(friend.id);
        if (actions['follow']['ok'] != null && actions['follow']['ok']) {
          isFollowing = true;
        }
        return Button(
          child: Text(isFollowing ? 'Following' : 'Follow'),
          isOutlined: true,
          textColor: primaryColor,
          borderRadius: 16.5,
          height: 27.0,
          width: 85.0,
          borderColor: isFollowing ? Colors.transparent : primaryColor,
          backgroundColor: isFollowing ? secondaryColor : Colors.transparent,
          onPressed: () async {
            if (isFollowing) {
              userStore.removeFollowingUserId(friend.id);

              await userStore.unFollowUser(friend.id);
            } else {
              userStore.addFollowingUserId(friend.id);
              await userStore.followUser(friend.id);
              notificationStore.fireAction(
                  notificationId: notification.id,
                  action: 'follow',
                  currUserId: userStore.details.id);
            }
          },
        );
      },
    );
  }
}
