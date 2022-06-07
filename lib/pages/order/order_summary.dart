import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/ordering/ordering_bloc.dart';
import 'package:Awoshe/pages/order/order.page.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  OrderSummary();

  @override
  OrderSummaryState createState() => new OrderSummaryState();
}

class OrderSummaryState extends State<OrderSummary> {
  int _radioValue = 0;
  PaymentMethod paymentMethod = PaymentMethod.CARD;
  OrderingBloc _orderingBloc;

  @override
  void didChangeDependencies() {
    if (_orderingBloc == null){
      _orderingBloc = Provider.of<OrderingBloc>(context);
      _orderingBloc.order.paymentMethod = paymentMethod.index;
    }

    super.didChangeDependencies();
  }

  void _setPaymentMethod(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _orderingBloc.order.paymentMethod = PaymentMethod.CARD.index;
          break;
        case 1:
          _orderingBloc.order.paymentMethod = PaymentMethod.BANK.index;
          break;
      }
    });
  }

//  Future<Null> prepareDraftOrder() async {
//    DateTime currentTime = DateTime.now();
//
//    widget.userOrder.createdAt = currentTime;
//    widget.userOrder.orderBy = AuthenticationService.appUserId;
//    widget.userOrder.status = OrderStatus.PREPARING.index;
//    widget.userOrder.paymentMethod = paymentMethod.index;
//
//  }

  Widget renderBilling() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Order Summary",
            style: textStyle1,
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Item(s) total"),
              Text(
                "\$" + _orderingBloc.order.itemsTotal.toString(),
                style: textStyle1,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Shipping"),
              Text(
                "\$" + _orderingBloc.order.shippingCharge.toString(),
                style: textStyle1,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Tax"),
              Text("\$" + _orderingBloc.order.taxCharge.toString(),
                  style: textStyle1)
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total"),
              Text(
                "\$" + _orderingBloc.order.total.toString(),
                style: textStyle2,
              )
            ],
          ),
        ],
      );

  Widget checkout() => Container(
    height: 65.0,
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: AwosheButton(
          childWidget: Text("Proceed to checkout",
            style: buttonTextStyle,
          ),
          onTap: () async {
                Navigator.of(context, rootNavigator: false).push(
                  CupertinoPageRoute<bool>(
                    fullscreenDialog: true,
                    builder: (BuildContext context) =>
                        MultiProvider(
                            providers: [
                              Provider<OrderingBloc>.value(value: _orderingBloc,)
                            ],
                          child: OrderAddressInfoPage(),
                        ),
                  ),
                );
              },
          buttonColor: primaryColor
      ),

    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Stack(children: <Widget>[

                  Container(
                    color: awLightColor,
                    height: 150.0,
                    child: Center(
                      child: Text( "Choose your payment method",
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        const IconData(0xe902, fontFamily: 'icomoon'),
                        size: 16.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ]),
              ),
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                children: <Widget>[
                  SizedBox(height: 30.0),
                  RadioListTile(
                    value: 0,
                    activeColor: primaryColor,
                    groupValue: _radioValue,
                    onChanged: _setPaymentMethod,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          Assets.masterCard,
                          fit: BoxFit.cover,
                          height: 45.0,
                          width: 60.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Image.asset(
                          Assets.visa,
                          fit: BoxFit.cover,
                          height: 45.0,
                          width: 60.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Image.asset(
                          Assets.americanExpress,
                          fit: BoxFit.cover,
                          height: 45.0,
                          width: 70.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RadioListTile(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _setPaymentMethod,
                    activeColor: primaryColor,
                    title: Row(
                      children: <Widget>[
                        Image.asset(
                          Assets.paypal,
                          fit: BoxFit.cover,
                          width: 70.0,
                          height: 45.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Divider(height: 2.0),
                  SizedBox(height: 30.0),
                  renderBilling(),
                  SizedBox(height: 40.0),
                  checkout(),
                ],
              ),
//          Align(
//            child: checkout(),
//            alignment: FractionalOffset.bottomCenter,
//          ),
              VerticalSpace(60.0)
            ],
          ),
        ));
  }
}
