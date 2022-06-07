import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/logic/stores/notification/notification_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/notification/notification.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'earlier_notification.dart';
import 'today_notification.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationStore notificationStore;
  UserStore userStore;
  bool _fetchingMore = false;

  @override
  void initState() {
    notificationStore = NotificationStore();
    userStore = Provider.of<UserStore>(context, listen: false);
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
//    notificationStore.dispose();
  }

  Future<void> initialize() async {
    if (notificationStore.notificationList.isEmpty) {
      notificationStore.fetchNotification(userStore.details.id);
    }
  }

  Widget emptyNotification() =>
      Center(
        child: Container(
          margin: EdgeInsets.only(top: .0),
          child: NoDataAvailable(
            message: 'No Notifications available',
          ),
        ),
      );

  Widget todayTextWidget() =>
      Container(
        height: 31.0,
        color: awLightColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
       // margin: EdgeInsets.only(top: 10.0),
        alignment: Alignment.centerLeft,
        child: Text(
          'Today',
          style: TextStyle(
              color: secondaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
      );

  Widget earlierTextWidget() =>
      Container(
        height: 31.0,
        color: awLightColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        alignment: Alignment.centerLeft,
       // margin: EdgeInsets.only(top: 10.0),
        child: Text(
          'Earlier',
          style: TextStyle(
              color: secondaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AwosheAppBar(
          center: false,
          title: 'Notifications',
        ),
        body: Container(

          margin: const EdgeInsets.only(top: 20.0),
//          top: false,
//          bottom: false,
          child: Observer(
            builder: (BuildContext context) {

              final ObservableList<Notifications> todayList =
                  notificationStore.todayNotificationList;

              final ObservableList<Notifications> earlierList =
                  notificationStore.earlierNotificationList;
              if (notificationStore.notificationList.isEmpty &&
                  notificationStore.loading)

                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 150.0),
                    child: AwosheLoadingV2(),
                  ),
                );
              return Provider<NotificationStore>.value(
                value: notificationStore,
                child: (!notificationStore.loading &&
                    notificationStore.notificationList.isEmpty)
                    ?
                emptyNotification()
                    :
                InfiniteListView(
                  endOffset: 100.0,
                  onEndReached: () async {
                    print('start fetching once end reached');

                    if (!_fetchingMore) {
                      if (!notificationStore.loading &&
                          notificationStore.notificationList.isEmpty)
                        return;
                      _fetchingMore = true;
                      await notificationStore
                          .fetchNotification(userStore.details.id);
                      _fetchingMore = false;
                    }
                    print('finish fetching after end reached');
                  },

                  itemCount: notificationStore.notificationList.length,

                  itemBuilder: (BuildContext context, int index) {
                    if (index == notificationStore.notificationList.length) {
                      if (notificationStore.allDataFetched)
                        return Container();
                      return Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: AwosheLoadingV2()
                      );
                    } else {

                      var todayContent;
                      var earlierContent;

                      if (todayList.length > 0 && index < todayList.length)
                       todayContent = todayList[index].content;

                      if (earlierList.length > 0 && index < earlierList.length)
                       earlierContent = earlierList[index].content;

                      return Column(
                        children: <Widget>[
                          if (todayList.length > 0 && index == 0)
                            todayTextWidget(),

                            (todayContent != null) ? TodayNotification(
                              notificationData: todayList[index],
                              userStore: userStore,
                              notificationStore: notificationStore,
                            ) : Container(),

                          if (earlierList.length > 0 && index == 0)
                            earlierTextWidget(),

                            (earlierContent != null) ? EarlierNotification(
                              notificationData: earlierList[index],
                              userStore: userStore,
                              notificationStore: notificationStore,
                            ) : Container(),
                        ],
                      );
                    }
                  },
                ),
              );
            },
          ),
        ));
  }
}
