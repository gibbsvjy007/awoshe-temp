import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/widgets/notification/notification_widget.dart';
import 'package:flutter/material.dart';

class TodayNotification extends StatefulWidget {
  final Notifications notificationData;
  final UserStore userStore;
  final NotificationStore notificationStore;

  TodayNotification(
      {this.notificationData, this.userStore, this.notificationStore});

  @override
  _TodayNotificationState createState() => _TodayNotificationState();
}

class _TodayNotificationState extends State<TodayNotification> {
  @override
  Widget build(BuildContext context) {
    return NotificationWidget(
      notificationsData: widget.notificationData,
      userStore: widget.userStore,
      notificationStore: widget.notificationStore,
    );
  }
}
