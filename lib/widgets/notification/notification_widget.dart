import 'package:Awoshe/components/message/user_avatar.dart';
import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/notification_utils.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'notification_tile.dart';

class NotificationWidget extends StatefulWidget {
  final Notifications notificationsData;
  final UserStore userStore;
  final NotificationStore notificationStore;

  NotificationWidget(
      {this.notificationsData, this.userStore, this.notificationStore});

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  Notifications notification;
  bool hasActions = false;
  Map<String, dynamic> actions = Map();
  List<Widget> actionWidget = [];
  TextStyle normalStyle = notificationTitleStyle.copyWith(
      fontWeight: FontWeight.w300, fontSize: 15.0);
  TextStyle boldStyle = notificationTitleStyle.copyWith(
      fontWeight: FontWeight.w600, fontSize: 15.0);
  String template;
  Map<String, dynamic> payload;
  List<TextSpan> textSpanList;
  Map<String, dynamic> styles;
  Map<String, dynamic> values;
  User targetUser;

  @override
  void initState() {
    notification = widget.notificationsData;
    hasActions = notification?.content['actions'] != null;
    actions = notification?.content['actions'];
    template = notification?.content['template'];
    payload = notification.payload;
    textSpanList = List<TextSpan>();
    styles = notification?.content['styles'];
    values = notification?.content['values'];
    if (payload['user'] != null)
      targetUser = User.fromJson(payload['user']);
    else if (payload['event'] != null)
      targetUser = User.fromJson(payload['order']['creator']);
    super.initState();
  }

  String getDataFromMap(Map payload, propertyData) {
    if (propertyData != "" && propertyData != null) {
      List<String> aMapKeys = propertyData.split('.');
      String s = '';
      if (aMapKeys.length < 3) {
        s = aMapKeys.reduce((o, k) {
          Map obj = payload[o];

          /// currently supporting only two level hierarchy and map. need to adapt this method with multi level hierarchy of object
          if (obj is Map && obj.containsKey(k)) {
            return obj[k];
          }
          return '';
        });
      }
      return s;
    }
    return "";
  }

  Widget getMessage() {
    List<String> templateStrings = template.split(" ");

    templateStrings.forEach((s) {
      TextStyle textStyle = normalStyle;
      String msg = '';
      if (s.indexOf('{') != -1) {
        String variableKey = s.replaceAll(RegExp(r'[{}.]'), '');
        String placeholder = StringUtils.capitalize(
            getDataFromMap(payload, values[variableKey]));
        if (styles.containsKey(variableKey)) {
          String style = styles[variableKey];
          if (style == 'bold') textStyle = boldStyle;
        }
        msg = placeholder + ' ';
      } else {
        msg = '' + s + ' ';
      }
      textSpanList.add(TextSpan(text: msg, style: textStyle));
    });
    return RichText(
      text: TextSpan(
          text: '',
          style: normalStyle.copyWith(height: 1.4),
          children: textSpanList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      name: 'notification',
      builder: (BuildContext context) {
        return NotificationTile(
          backgroundColor: Colors.transparent,
          title: getMessage(),
          leading: UserAvatar(
            avatarUrl: targetUser.thumbnailUrl,
            userId: targetUser.id,
            fullName: targetUser.name,
          ),
          trailing: hasActions
              ? NotificationUtils.getNotificationActionsByType(
                  notification,
                  targetUser,
                  widget.userStore,
                  context,
                  widget.notificationStore)
              : NotificationUtils.getSubTitle(notification),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          onTap: () {},
        );
      },
    );
  }
}
