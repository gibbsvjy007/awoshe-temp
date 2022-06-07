import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/widgets/notification/notification_widget.dart';
import 'package:flutter/material.dart';

class EarlierNotification extends StatefulWidget {
  final Notifications notificationData;
  final UserStore userStore;
  final NotificationStore notificationStore;

  EarlierNotification(
      {this.notificationData, this.notificationStore, this.userStore});

  @override
  _EarlierNotificationState createState() => _EarlierNotificationState();
}

class _EarlierNotificationState extends State<EarlierNotification> {
  @override
  Widget build(BuildContext context) {
    return NotificationWidget(
      notificationsData: widget.notificationData,
      userStore: widget.userStore,
      notificationStore: widget.notificationStore,
    );
  }
}
