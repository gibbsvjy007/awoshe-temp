import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/ordering/ordering_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/upload.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
// import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

class PaymentOrder extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final Function paymentValid;
  final Order userOrder;

  PaymentOrder({this.paymentMethod, this.paymentValid, this.userOrder});

  @override
  PaymentOrderState createState() => new PaymentOrderState();
}

class PaymentOrderState extends State<PaymentOrder> {
  OrderingStore store;
  UserStore userStore;
  GlobalKey<FormState> paymentForm = GlobalKey<FormState>();
  StripeCard card;

  bool isShippingSameAsBilling = false;
  SelectableItem sameAddressItem =
      SelectableItem(title: null, isSelected: false);
  TextEditingController creditCardNo1,
      creditCardNo2,
      creditCardNo3,
      creditCardNo4,
      creditCardMonth,
      creditCardYear,
      creditCardCVV,
      creditCardName;

  @override
  void initState() {
    super.initState();
    store = Provider.of<OrderingStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);

    creditCardNo1 = TextEditingController();
    creditCardNo2 = TextEditingController();
    creditCardNo3 = TextEditingController();
    creditCardNo4 = TextEditingController();
    creditCardMonth = TextEditingController();
    creditCardYear = TextEditingController();
    creditCardCVV = TextEditingController();
    creditCardName = TextEditingController();
    creditCardNo1.text = "4084";
    creditCardNo2.text = "0840";
    creditCardNo3.text = "8408";
    creditCardNo4.text = "4081";
    creditCardMonth.text = "12";
    creditCardYear.text = "2020";
    creditCardCVV.text = "408";
    creditCardName.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    creditCardNo1.dispose();
    creditCardNo2.dispose();
    creditCardNo3.dispose();
    creditCardNo4.dispose();
    creditCardMonth.dispose();
    creditCardYear.dispose();
    creditCardCVV.dispose();
    creditCardName.dispose();
  }

  Widget cardNumber() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                      width: 50.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "XXXX",
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: creditCardNo1,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          creditCardNo1.text = value;
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                      width: 50.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "XXXX",
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: creditCardNo2,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          creditCardNo2.text = value;
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                      width: 50.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "XXXX",
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: creditCardNo3,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          creditCardNo3.text = value;
                        },
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                      width: 50.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "XXXX",
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: creditCardNo4,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          creditCardNo4.text = value;
                        },
                      )),
                ),
              ],
            ),
          ),
          Icon(
            Icons.credit_card,
            color: awLightColor,
            size: 28.0,
          )
        ],
      );

  Widget expiryAndSecurityCode() => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Expiration Date",
                      style: textStyle14,
                    ),
                    VerticalSpace(10.0),
                    Row(
                      children: <Widget>[
                        Container(
                            width: 50.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "XX",
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                              controller: creditCardMonth,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              onSaved: (String value) {
                                creditCardMonth.text = value;
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                        Container(
                            width: 50.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "XXXX",
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              controller: creditCardYear,
                              keyboardType: TextInputType.number,
                              onSaved: (String value) {
                                creditCardYear.text = value;
                              },
                            )),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Security Code",
                      style: textStyle14,
                    ),
                    VerticalSpace(10.0),
                    Container(
                        width: 50.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "XXX",
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                          controller: creditCardCVV,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onSaved: (String value) {
                            creditCardCVV.text = value;
                          },
                        ))
                  ],
                )
              ],
            ),
          ),
          Icon(
            Icons.lock,
            color: awLightColor,
            size: 28.0,
          )
        ],
      );

  Widget button() => Observer(
        builder: (_) {

          return AwosheButton(
              childWidget: (store.checkoutStatus == CheckoutStatus.DOING)
                  ? DotSpinner()
                  : Text('Submit', style: buttonTextStyle),
              onTap: (store.checkoutStatus == CheckoutStatus.DOING)
                  ? null
                  : _doPayment,
              width: double.infinity,
              height: 50.0,
              buttonColor: primaryColor);
        },
      );

  void _doPayment() async {
      paymentForm.currentState.save();

      var invalidCard = validate(
        month: creditCardMonth.text,
        year: creditCardYear.text,
        name: creditCardName.text,
        securityCode: creditCardCVV.text,
        cardNumber: '${creditCardNo1.text}${creditCardNo2.text}${creditCardNo3.text}${creditCardNo4.text}'
      );
      
      if ( invalidCard == null ){
        store.orderingWithStripe(card,
          userStore.details.id,
          userStore.details.currency,
        )
        .then( (_) => store.finishOrdering(context, userStore.details.id))
        .catchError( (_) =>  ShowFlushToast(
          context, ToastType.ERROR,store.checkoutErrorMsg)
        );
      }

      else {
        ShowFlushToast(context, ToastType.WARNING, invalidCard);
        return;
      }

    }
  

   Widget creditCardWidget() => Form(
         key: paymentForm,
         autovalidate: false,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text(
               "Enter your payment details",
               style: textStyle2,
             ),
             VerticalSpace(20.0),
             Text(
               "Card Number",
               style: textStyle14,
             ),
             VerticalSpace(10.0),
             cardNumber(),
             VerticalSpace(30.0),
             expiryAndSecurityCode(),
             VerticalSpace(30.0),
             Text(
               "Name On Card",
               style: textStyle14,
             ),
             VerticalSpace(10.0),
             InputField(
                 hintStyle: TextStyle(color: secondaryColor),
                 obscureText: false,
                 textInputType: TextInputType.text,
                 hintText: "Name",
                 textStyle: textStyle,
                 borderColor: awLightColor,

                 isBorder: true,
                 leftPadding: 15.0,
                 controller: creditCardName,
                 textInputAction: TextInputAction.done,
                 textFieldColor: textFieldColor,
                 bottomMargin: 10.0,
                 onSaved: (String name) {
                   creditCardName.text = name;
                 }),
           ],
         ),
       );

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('Payment Details'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CardForm(
              //   card: card,
              //   formKey: paymentForm,
              // ),
             creditCardWidget(),
                  //?
                  //: Text("You have choosen Bank payment"),
              SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Total: ',
                    style: textStyle2,
                  ),
                  Text(
                    '${userStore.details.currency} '
                    '${PriceUtils.formatPriceToString(store.order.total)}',
                    style: textStyle2,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              button()
            ],
          ),
        ),
      ),
    );
  }

  String validate({String cardNumber, 
    String month, String year,
    String securityCode, String name}) {

     if (name == null || name.isEmpty)
      return 'Name is required';

     if (month == null || month.isEmpty)
      return 'Expiration month is required';   

     if (year == null || year.isEmpty)
      return 'Expiration year is required'; 
     card = StripeCard(
      name: name,
      number: cardNumber,
      cvc: securityCode,
      expMonth: int.parse(month),
      expYear: int.parse(year),
    );
    
    if ( !card.validateNumber() )
      return 'Invalid card number';
    
    if (!card.validateCVC())
      return 'Invalid CVC';  

    if (!card.validateDate())
      return 'Invalid expiration date';

     if (!card.validateCard()) 
      return 'Invalid card';

    return null;
  }
}
