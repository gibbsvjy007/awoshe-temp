import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/api/user_api.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/creator/creator.dart';
import 'package:Awoshe/models/measurement/measurement.dart';
import 'package:Awoshe/models/order/designer_order_item.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/awoshe_dropdown_button.dart' as awosheDropDown;
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:Awoshe/widgets/profile/order/product_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class DesignerOrderDetail extends StatefulWidget {
  final String orderId;
  final ProfileStore profileStore;
  final String title;

  DesignerOrderDetail({this.orderId, this.profileStore, this.title});

  @override
  _DesignerOrderDetailState createState() => _DesignerOrderDetailState();
}

class _DesignerOrderDetailState extends State<DesignerOrderDetail> {
  int currentStatus = 0;
  Stream orderStream;
  DesignerOrderItem orderItem;

  UserStore userStore;

  @override
  void initState() {
    initialize();
    userStore = Provider.of<UserStore>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initialize() async {
    await widget.profileStore.fetchDesignerOrderDetail(orderId: widget.orderId);
    currentStatus = widget.profileStore.currentDeliveryStatus;
  }

  Widget buildSize(Measurement measurement) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Size(s):',
              style: textStyle,
            ),
            width: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Small', style: lightText),
              Text('Chest: ' + '${ measurement != null
                  ? measurement.chest.toString()
                  : '0.0' }', style: lightText),
              Text('Height: 169cm', style: lightText),
              Text('Waist: 29cm', style: lightText),
              Text('Burst: 69cm', style: lightText),
            ],
          )
        ],
      );

  Widget buildUserInfo(Creator orderBy) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Ordered By:',
              style: textStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            width: 100,
          ),
          Text(
            orderBy.name,
            style: lightText,
          )
        ],
      );

  Widget buildAddressInfo(Address shippingAddress) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Address:',
              style: textStyle,
            ),
            width: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(shippingAddress.fullName,
                  style: TextStyle(color: awLightColor, fontSize: 16.0)),
              Text(shippingAddress.street, style: lightText),
              Text(shippingAddress.city + ', ' + shippingAddress.zipCode,
                  style: lightText),
              Text(shippingAddress.state, style: lightText),
              Text(shippingAddress.country, style: lightText),
            ],
          )
        ],
      );

  Widget buildDelivery() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Delivery:',
              style: textStyle,
            ),
            width: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Express: Within 1 Week",
                  style: TextStyle(color: awLightColor, fontSize: 16.0)),
            ],
          )
        ],
      );

  Widget buildStatusInfo() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              'Status:',
              style: textStyle,
            ),
            width: 100,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  child: Container(
                      height: 30,
                      width: 125,
                      child: Observer(
                          name: 'delivery_status_dropdown',
                          builder: (context) {
                            int status = widget.profileStore
                                .currentDeliveryStatus;
                            return Center(
                                child: awosheDropDown
                                    .DropdownButtonHideUnderline(
                                  child: awosheDropDown.AwosheDropdownButton(
                                      hint: Text(
                                        Utils.getDelieveryStatus(status),
                                        style: textStyle12sec,
                                        textAlign: TextAlign.center,
                                      ),
                                      value: Utils.getDelieveryStatus(status),
                                      items: ORDER_STATUS.map<
                                          awosheDropDown.DropdownMenuItem<
                                              String>>(
                                              (String value) {
                                            print(value);
                                            return awosheDropDown
                                                .DropdownMenuItem(
                                              child: Text(
                                                  value, style: textStyle12sec),
                                              value: value,
                                            );
                                          }).toList(),
                                      onChanged: (newStatus) {
                                        int s = ORDER_STATUS.indexOf(newStatus);
                                        if (ORDER_STATUS.indexOf(newStatus) !=
                                            currentStatus) {
                                          widget.profileStore.setDeliveryStatus(
                                              s);
                                        }
                                      }),
                                ));
                          }
                      )),
                  shape: StadiumBorder(
                      side: BorderSide(color: secondaryColor, width: 1.0)),
                ),
                Container(
                  height: 30,
                  width: 70,
                  child: FlatButton(
                    onPressed: () {
                      widget.profileStore.updateDeliveryStatus();
                      ShowFlushToast(
                          context, ToastType.INFO, "Delivery status updated.");
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(color: primaryColor),
                    ),
                    shape: StadiumBorder(side: BorderSide(color: primaryColor)),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget buildSendReviewTemplate() => Container(
        child: RoundedButton(
            buttonName: Localization.of(context).sendReviewTemplate,
            onTap: () {
              UserApi.sendReviewTemplate(
                  userStore.details.id,
                  orderId: orderItem.id,
                  buyerId: orderItem.creator.id,
              );

              Utils.showAlertMessage(context,
                  title: 'Review Request',
                message: 'Your review request has been sent to ${orderItem.creator.name}.',
                onConfirm: () => Navigator.pop(context),
                confirmText: 'Ok',
              );
            },

            width: double.infinity,
            height: 50.0,
            buttonColor: primaryColor),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        controller: ScrollController(),
        child: Observer(
            name: 'designer_order_detail',
            builder: (BuildContext context) {
              if (widget.profileStore.loadingOrderDetail)
                return Center(child: AwosheLoadingV2());
              if (widget.profileStore.currentDesignerOrder.id.isNotEmpty) {
                orderItem = widget.profileStore.currentDesignerOrder;

                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      ProductInfoTile(
                        orderItem: orderItem,
                      ),
                      SizedBox(height: 10.0),
                      buildUserInfo(orderItem.creator),
                      SizedBox(height: 10.0),
                      buildAddressInfo(orderItem.shippingAddress),
                      SizedBox(height: 10.0),
                      buildSize(orderItem.measurements),
                      SizedBox(height: 10.0),
                      buildDelivery(),
                      SizedBox(height: 20.0),
                      buildStatusInfo(),
                      SizedBox(height: 20.0),
                      Divider(color: primaryColor),
                      SizedBox(height: 20.0),
                      buildSendReviewTemplate()
                    ],
                  ),
                );
              } else {
                return NoDataAvailable();
              }
            }),
      )),
    );
  }
}
