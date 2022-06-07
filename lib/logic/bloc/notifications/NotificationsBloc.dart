import 'dart:async';

import 'package:Awoshe/models/UserNotification.dart';
import 'package:Awoshe/models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:Awoshe/logic/bloc_helpers/bloc_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:Awoshe/services/profile.service.dart';

class NotificationsBloc extends BlocBase {

  static DateTime now = DateTime.now();
  static DateTime start = DateTime(now.year, now.month, now.day, 0, 0);
  static DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);
  Timestamp st = Timestamp.fromDate(start);
  Timestamp et = Timestamp.fromDate(end);

  Observable< List< UserNotification> > todayNotificationStream;
  Observable< List< UserNotification> > earlierNotificationStream;

  NotificationsBloc(){
    //_init();

  }

  init(){
//    todayNotificationStream = Observable( _service.getTodayNotifications(st) ).transform( _transformer );
//    earlierNotificationStream = Observable( _service.getEarlierNotifications(et) ).transform( _transformer);
  }

  int getTimeDifference(Timestamp dt) {
    int timeDiff = Timestamp
        .now()
        .millisecondsSinceEpoch - dt.millisecondsSinceEpoch;
    return timeDiff;
  }

  @override
  void dispose() { }

  Future<String> getUserProfile(String userId) async {
    UserProfile profile = await ProfileService.getProfileByUserId(userId);
    return profile?.images?.profileUrl;
  }

  String timeAgo(int msTimeDiff) => timeago.format(
      now.subtract( Duration(milliseconds: msTimeDiff) ), locale: 'en_short');

}