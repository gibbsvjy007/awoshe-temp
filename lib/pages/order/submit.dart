import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/ordering/ordering_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/order/payment.dart';
import 'package:Awoshe/pages/order/payment_webview_page.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SubmitOrderPage extends StatefulWidget {
  @override
  SubmitOrderPageState createState() => new SubmitOrderPageState();
}

class SubmitOrderPageState extends State<SubmitOrderPage> {
  dynamic deviceSize;
  //int _radioValue = 0;
  OrderingStore orderingStore;
  UserStore userStore;

  @override
  void didChangeDependencies() {
    if (orderingStore == null) {
      orderingStore = Provider.of<OrderingStore>(context);
      orderingStore.order.paymentMethod = PaymentMethod.CARD.index;
    }

    userStore ??= Provider.of<UserStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('Ordering Confirm'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Please submit your order",
                  style: textStyle2,
                ),
                VerticalSpace(10.0),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                            "By clicking Submit order, you agree to Awoshe’s ",
                        style: TextStyle(color: awLightColor, fontSize: 12.0)),
                    TextSpan(
                      text: "Terms of Use ",
                      style: TextStyle(
                          color: awLightColor,
                          decoration: TextDecoration.underline,
                          fontSize: 12.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchURL('Terms and Condition',
                            'terms_and_condition', context),
                    ),
                    TextSpan(
                        text: " and ",
                        style: TextStyle(color: awLightColor, fontSize: 12.0)),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          color: awLightColor,
                          decoration: TextDecoration.underline,
                          fontSize: 12.0),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchURL(
                            'Privacy Policy', 'privacy_policy', context),
                    ),
                  ]),
                ),
                VerticalSpace(20.0),
                renderAddress(),
                VerticalSpace(20.0),

                renderPaymentMethod(),
                VerticalSpace(20.0),
                // Padding(
                //   padding: EdgeInsets.all(10.0),
                //   child: CommonDivider(),
                // ),
                renderBill(),
                VerticalSpace(35.0),
                submitButton(),
              ]),
        ),
      ),
    );
  }

  Widget renderAddress() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Shipping Address",
              style: textStyle14sec,
            ),
            VerticalSpace(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          "Name: " +
                              orderingStore.order.shippingAddress?.fullName,
                          style: TextStyle(color: awLightColor)),
                      Text(
                          "Address: " +
                              orderingStore.order.shippingAddress?.street,
                          style: TextStyle(color: awLightColor)),
                      Text("City: " + orderingStore.order.shippingAddress?.city,
                          style: TextStyle(color: awLightColor)),
                      Text(
                          "State: " +
                              orderingStore.order.shippingAddress?.state,
                          style: TextStyle(color: awLightColor)),
                      Text(
                          "Country: " +
                              orderingStore.order.shippingAddress?.country,
                          style: TextStyle(color: awLightColor)),
                      Text(
                          "Postal code: " +
                              orderingStore.order.shippingAddress?.zipCode,
                          style: TextStyle(color: awLightColor)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget renderPaymentMethod() => Observer(
        builder: (_) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Your Bill",
                style: textStyle,
              ),
              //VerticalSpace(10.0),
//               Column(
//                 children: <Widget>[
//                   RadioListTile(
//                     value: 0,
//                     activeColor: primaryColor,
//                     groupValue: _radioValue,
//                     onChanged: (value){
//                       switch (_radioValue) {
//                         case 0:
//                           orderingStore.setPaymentMethod(PaymentMethod.CARD);
//                           break;
//                        case 1:
//                          orderingStore.setPaymentMethod(PaymentMethod.BANK);
//                          break;
//                       }
//                     },
//                     title: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Image.asset(
//                           Assets.masterCard,
//                           fit: BoxFit.cover,
//                           height: 45.0,
//                           width: 60.0,
//                         ),
//                         Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),),
//                         Image.asset(
//                           Assets.visa,
//                           fit: BoxFit.cover,
//                           height: 45.0,
//                           width: 60.0,
//                         ),
//                         Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),),

//                         Image.asset(
//                           Assets.americanExpress,
//                           fit: BoxFit.cover,
//                           height: 45.0,
//                           width: 70.0,
//                         ),
//                       ],
//                     ),
//                   ),

// //                TODO allowing PAYPAL payment method!
// //                RadioListTile(
// //                  value: 1,
// //                  groupValue: _radioValue,
// //                  onChanged: _setPayment,
// //                  activeColor: primaryColor,
// //                  title: Row(
// //                    children: <Widget>[
// //                      Image.asset(
// //                        Assets.paypal,
// //                        fit: BoxFit.cover,
// //                        width: 70.0,
// //                        height: 45.0,
// //                      ),
// //                    ],
// //                  ),
// //                ),
//                 ],
//               ),
            ],
          ),
        ),
      );

  Widget renderBill() => Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Item(s) total"),
              Text(
                "${userStore.details.currency} " +
                    PriceUtils.formatPriceToString(
                        orderingStore.order.itemsTotal),
                style: textStyle,
              )
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Shipping and Taxes will be communicated", style: textStyle, textAlign: TextAlign.center,),
//              Text(
//                "${userStore.details.currency} " +
//                    PriceUtils.formatPriceToString(
//                        orderingStore.order.shippingCharge),
//                style: textStyle,
//              )
              ],
            ),
          ),
//          Row(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text("Tax"),
//              Text(
//                  "${userStore.details.currency} " +
//                      PriceUtils.formatPriceToString(
//                          orderingStore.order.taxCharge),
//                  style: textStyle)
//            ],
//          ),

          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total"),
              Text(
                "${userStore.details.currency} " +
                    PriceUtils.formatPriceToString(orderingStore.order.total),
                style: textStyle2,
              )
            ],
          ),
        ],
      );

  Widget submitButton() => Observer(
        builder: (context) {
          return AwosheButton(
              childWidget:
                  (orderingStore.checkoutStatus == CheckoutStatus.DOING)
                      ? DotSpinner()
                      : Text('Checkout', style: buttonTextStyle),
              onTap: (orderingStore.checkoutStatus == CheckoutStatus.DOING)
                  ? null
                  : () async {
                      // if currency == 'GHS' pay with iPay
                      //payWithIPay();
                      if (userStore.details.currency == CURRENCIES[1]) {
                        payWithIPay();
                      } 
                      
                      // // or pay with stripe.
                      else {
                        Navigator.push(context,
                        CupertinoPageRoute(
                          builder: (_) => Provider(
                            builder: (_) => orderingStore,
                            child: PaymentOrder(
                              paymentMethod: orderingStore.paymentType,
                              paymentValid: (){},
                              userOrder: orderingStore.order,
                            ),
                          ),
                        ),
                      );

                      }
                    },
              width: deviceSize.width,
              height: 50.0,
              buttonColor: primaryColor);
        },
      );

  void payWithIPay() {
    orderingStore
        .createNewOrder(
            uid: userStore.details.id,
            currency: userStore.details.currency,
            userEmail: userStore.details.email)
        .then((_) {
      print('Pushing the page');
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => PaymentWebViewPage(
                    data: orderingStore.paymentPage,
                    orderingStore: orderingStore,
                  )));
    }).catchError((ex) {
      ShowFlushToast(context, ToastType.ERROR, ex.toString());
    });
  }

}
