import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/pages/profile/order/profile_designer_order_detail.dart';
import 'package:Awoshe/pages/profile/order/profile_user_order_detail.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/shared/infinite_list_view.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfileOrderTab extends StatefulWidget {
  final ProfileStore profileStore;
  final UserStore userStore;

  ProfileOrderTab({this.profileStore, this.userStore});

  @override
  _ProfileOrderTab createState() => new _ProfileOrderTab();
}

class _ProfileOrderTab extends State<ProfileOrderTab> {
  bool _fetchingMore = false;
  ProfileStore profileStore;

  @override
  void initState() {
    super.initState();
    profileStore = widget.profileStore;
    widget.profileStore.fetchOrders();
  }

  Widget buildOrderIcon() => ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 14.0,
        ),
      ),
    ),
  );

  Widget buildOrderTile(Order order) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 30.0),
          dense: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                    (widget.userStore.details.isDesigner)
                        ? DesignerOrderDetail(orderId: order.id, title: order.orderId, profileStore: profileStore)
                        : UserOrderDetail(orderId: order.id, title: order.orderId, profileStore: profileStore)
                ));
          },
          leading: buildOrderIcon(),
          title: Text(
              order.orderId.toUpperCase(),
              style: textStyle),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AwosheSimpleAppBar(
        title: "Orders",
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Observer(
          name: 'orders',
          builder: (BuildContext context) {
            if (profileStore.loading &&
                profileStore.orderList.isEmpty) {
              return AwosheLoadingV2();
            }
            return Provider<ProfileStore>.value(
              value: profileStore,
              child: (!profileStore.loading &&
                  profileStore.orderList.isEmpty)
                  ? NoDataAvailable()
                  : InfiniteListView(
                endOffset: 100.0,
                onEndReached: () async {
                  print('start fetching once end reached');

                  if (!_fetchingMore) {
                    if (!profileStore.loading &&
                        profileStore.orderList.isEmpty) return;
                    _fetchingMore = true;
                    await profileStore.fetchOrders();
                    _fetchingMore = false;
                  }
                  print('finish fetching after end reached');
                },
                itemCount: profileStore.orderList.length,
                itemBuilder: (BuildContext context, int index) {
                  print(profileStore.orderList.length);
                  if (index == profileStore.orderList.length) {
                    return AwosheLoadingV2();
                  } else {
                    final Order order = profileStore.orderList[index];
                    return buildOrderTile(order);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
