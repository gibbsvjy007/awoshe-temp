import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/models/notification/notification_types.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/notification/n_user_follow.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationUtils {
  static Widget getNotificationActionsByType(
      Notifications notification,
      User user,
      UserStore userStore,
      BuildContext context,
      NotificationStore notificationStore) {
    switch (notification.type) {
      case NotificationType.USER_FOLLOW:
        return NUserFollow(
            userStore: userStore,
            friend: user,
            notification: notification,
            notificationStore: notificationStore);
        break;

      default:
    }
    return Container();
  }

  static Widget getSubTitle(Notifications notification) {
    DateTime createdOn = DateTime.fromMillisecondsSinceEpoch(
        notification.createdOn.millisecondsSinceEpoch);
    return Row(
      children: <Widget>[
        Text(
            timeago.format(
              createdOn,
              locale: 'en_short',
            ),
            style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0))
      ],
    );
  }
}
