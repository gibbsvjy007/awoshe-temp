import 'dart:convert';

import 'package:Awoshe/logic/bloc_helpers/bloc_singleton.dart';
import 'package:Awoshe/utils/message_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// pushnotification service. all the functions of pushnotification will go here.
class PushNotificationService {
  static FirebaseMessaging _messaging = FirebaseMessaging();
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  PushNotificationService();

  static setupNotification(String userId) async {
    print("Setting up Notification: " + userId);
    try {
      /// setup local push notification here
      AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
      InitializationSettings initializationSettings = InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);

      /// setup firebase push notification
      _messaging
        ..configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");

            /// need to handle local push notification here as firebase always
            /// sends notification when app is in background and closed
            /// When chat window is open then we dont send the notification at all but we get the notification here.
            ///
//            handleReceivedMessage(message);
          },
          onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            handleOnLaunch(message);

            /// when user taps on the notification we handle the navigation here.
            /// should directly goto chat screen if it is the type of message
            ///
          },
          onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
          },
        );

      _messaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      _messaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });

      // String token = await _messaging.getToken();
//      if (userId != null) {
//        ProfileService profileService = ProfileService(userId);
//        profileService.registerToken(token);
//      }
    } catch (e) {
      print("Error while setting up the push notification");
    }
  }

  static handleReceivedMessage(Map<String, dynamic> message) async {
    print(message);

    print("__________handleReceivedMessage____________");
    bool isChatWindowOpen = await MessageUtils.isChatWindowOpen();
//    print(message);
    Map<dynamic, dynamic> payload = message['data'];
    if (payload != null) {
      print(isChatWindowOpen);
      String messageType = payload['messageType'];
      String content = payload['message'];
      print(messageType);
      print(content);
      if (messageType == "ORDER") {
        String title = payload['title'];
        AndroidNotificationDetails androidSpecifics = AndroidNotificationDetails(
            title, title, content,
            importance: Importance.Max, priority: Priority.High);
        IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
        NotificationDetails platformChannelSpecifics =
        NotificationDetails(androidSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, title, content, platformChannelSpecifics,
            payload: json.encode(payload));
      } else if (messageType == "MESSAGE") {
        String conversationId = payload['conversationId'];
        String receiverName = payload['receiverName'];
        String receiverId = payload['receiverId'];
        String senderName = payload['senderName'];
        if (!isChatWindowOpen) {
          /// chat window not open? then send the local push notification
          AndroidNotificationDetails androidSpecifics =
          AndroidNotificationDetails(conversationId, receiverName, content,
              importance: Importance.Max, priority: Priority.High);
          IOSNotificationDetails iOSPlatformChannelSpecifics =
          IOSNotificationDetails();
          NotificationDetails platformChannelSpecifics =
          NotificationDetails(androidSpecifics, iOSPlatformChannelSpecifics);
          await flutterLocalNotificationsPlugin.show(
              0, senderName, content, platformChannelSpecifics,
              payload: json.encode(payload));

          print("____update unread count____");

          /// update an unread message count
          MessageUtils.updateUnreadCount(receiverId, conversationId, content);
        } else {
          /// if chat window is open then reset the count to 0
          MessageUtils.resetUnreadCount(receiverId, conversationId);
        }
      }
    }

  }

  static handleOnLaunch(Map<String, dynamic> message) async {}

  static Future onSelectNotification(String payload) async {
    print("________onSelectNotification__________");
    print(payload);
    Map data = jsonDecode(payload);

    /// navigate to chat detail screen with receiver details
    globalBloc.pushMap(data);
  }
}
