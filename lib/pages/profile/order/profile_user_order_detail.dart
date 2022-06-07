import 'package:Awoshe/components/product/product_image.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/order/order_item.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UserOrderDetail extends StatefulWidget {
  final String orderId;
  final ProfileStore profileStore;
  final String title;

  UserOrderDetail({this.orderId, this.profileStore, this.title});

  @override
  _UserOrderDetailState createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> {
  int currentOrderStatus = OrderStatus.PREPARING.index;

  CurrencyStore currencyStore;
  UserDetails details;
  UserStore userStore;

  @override
  void initState() {
    super.initState();
    currencyStore = Provider.of<CurrencyStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);
    details = userStore.details;
    initialize();
  }

  void initialize() async {
    await widget.profileStore.fetchOrderDetail(orderId: widget.orderId);
  }

  Widget buildStepIcon(int index) => ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: index <= currentOrderStatus ? secondaryColor : awLightColor,
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

  List<Widget> buildStepper() {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < ORDER_STATUS.length; i += 1) {
      children.add(Expanded(
        child: Container(
          height: 60.0,
          width: double.infinity,
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                  alignment: Alignment(1.0, 0.5),
                  widthFactor: double.infinity,
                  child: Container(
                    height: 1.0,
                    color: awLightColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(ORDER_STATUS[i],
                          style:
                              TextStyle(fontSize: 11.5, color: secondaryColor)),
                    ),
                    SizedBox(height: 10.0),
                    buildStepIcon(i),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return children;
  }

  Widget buildOrderItems(orderItems) => Column(
        children: orderItems.map<Widget>((OrderItem orderItem) {

          var itemValue = PriceUtils.formatPriceToDouble(orderItem.price);

          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 10.0),
            child: Row(
              children: <Widget>[
                ProductImage(imageUrl: orderItem.productImageUrl,),
                SizedBox(width: 15.0),
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          orderItem.productTitle,
                          style: textStyle1,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          orderItem.productCreator.name,
                          style: const TextStyle(
                            color: awLightColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Text(
                          "${details.currency} " + PriceUtils.formatPriceToString(
                              currencyStore.convertValue(value: itemValue,
                                  from: orderItem.currency,
                                  to: details.currency
                              )
                          ),
                          style: textStyle1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );

  Widget buildOrderBilling(Order orderData) => Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Item(s) total"),
          Text(
            "${details.currency} " + PriceUtils.formatPriceToString(
              currencyStore.convertValue(value: orderData.itemsTotal,
                  from: orderData.currency,
                  to: details.currency
              )
            ),
            style: textStyle1,
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Shipping"),
          Text(
            "${details.currency} " + PriceUtils.formatPriceToString(
                currencyStore.convertValue(
                    value: orderData.shippingCharge,
                    from: orderData.currency,
                    to: details.currency
                )
            ),
            style: textStyle1,
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Tax"),
          Text("${details.currency} " + PriceUtils.formatPriceToString(
              currencyStore.convertValue(
                  value: orderData.taxCharge,
                  from: orderData.currency,
                  to: details.currency
              )
          ), style: textStyle1)
        ],
      ),
      SizedBox(height: 20.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Total"),
          Text(
            "${details.currency} " + PriceUtils.formatPriceToString(
                currencyStore.convertValue(
                    value: orderData.itemsTotal,
                    from: 'USD',
                    to: details.currency)
            ),
            style: textStyle2,
          )
        ],
      )
    ],
  );

  Widget buildOrderDetail() => Observer(
        name: 'user_order_detail',
        builder: (BuildContext context) {
          if (widget.profileStore.loadingOrderDetail)
            return AwosheLoadingV2();
          print(widget.profileStore.currentOrder.id);
          if (widget.profileStore.currentOrder.id.isNotEmpty)
            return Column(
              children: <Widget>[
                buildOrderItems(widget.profileStore.currentOrder.orderItems),
                SizedBox(height: 10.0),
                Divider(height: 1.0),
                SizedBox(height: 10.0),
                buildOrderBilling(widget.profileStore.currentOrder)
              ],
            );
          else
            return NoDataAvailable();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buildStepper(),
              ),
              SizedBox(height: 30.0),
              buildOrderDetail(),
            ],
          ),
        ),
      ),
    );
  }
}
