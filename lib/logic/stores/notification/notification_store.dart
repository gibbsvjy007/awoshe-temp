
import 'package:Awoshe/logic/api/notification_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  static DateTime now = DateTime.now();
  static DateTime start = DateTime(now.year, now.month, now.day, 0, 0);
  static DateTime end = DateTime(now.year, now.month, now.day, 23, 59, 59);
  static int limit = 10;
  int fetchedNotification = 0;

  @observable
  bool allDataFetched = false;

  @observable
  bool loading = false;

  @observable
  ObservableList<Notifications> notificationList =
      ObservableList<Notifications>();
  @observable
  ObservableList<Notifications> todayNotificationList =
      ObservableList<Notifications>();
  @observable
  ObservableList<Notifications> earlierNotificationList =
      ObservableList<Notifications>();

  @observable
  ObservableList<String> frAcceptedList = ObservableList<String>();
  @observable
  ObservableList<String> frRejectedList = ObservableList<String>();

  @observable
  ObservableList<String> eventInviteAcceptList = ObservableList<String>();
  @observable
  ObservableList<String> eventInviteRejectList = ObservableList<String>();

  @action
  void addAcceptedFR(String id) {
    frAcceptedList.add(id);
  }

  @action
  void addRejectedFR(String id) {
    frRejectedList.add(id);
  }

  @action
  void addEventInviteAcceptedRequest(String id) {
    eventInviteAcceptList.add(id);
  }

  @action
  void addEventInviteRejectRequest(String id) {
    eventInviteRejectList.add(id);
  }

  @action
  void setLoading(bool isLoading) {
    loading = isLoading;
  }

  @action
  void setNotification(List<Notifications> p) {
    /// distinguish notifications according to timestamp
    notificationList.addAll(p);
    p.forEach((Notifications n) {
      print(n.toJson());
      if (n.createdOn.millisecondsSinceEpoch < start.millisecondsSinceEpoch) {
        earlierNotificationList.add(n);
      } else {
        todayNotificationList.add(n);
      }
    });
  }

  Future<void> fetchNotification(String loggedInUser) async {
    try {
      setLoading(true);
      RestServiceResponse response = await NotificationApi.getUserNotifications(
        userId: loggedInUser, page: fetchedNotification, limit: limit);
        
        if (response.content != null && response.content.length > 0) {
          List<Notifications> l = response.content.map<Notifications>((n) {
            return Notifications.fromJson(n);
          }).toList();
            
          fetchedNotification++;
          setNotification(l ?? []);
        } 
    
        else {
          allDataFetched = fetchedNotification > 0;
        }
    } 
    
    catch (ex){
      allDataFetched = fetchedNotification > 0;
      setNotification([]);
    }

    setLoading(false);
  }

  Future<void> fireAction({
    @required String notificationId,
    @required String currUserId,
    @required String action,
  }) async {
    NotificationApi.fireAction(
        notificationId: notificationId, currUserId: currUserId, action: action);
  }
}
