import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/ordering/ordering_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/order/order.page.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:Awoshe/widgets/cart/cart_empty.dart';
import 'package:Awoshe/widgets/cart/cart_item_tile.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Localization localization;
  CartStore cartStore;
  UserStore userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cartStore ??= Provider.of<CartStore>(context);
    userStore ??= Provider.of<UserStore>(context);
    initialize();
    super.didChangeDependencies();
  }

  void initialize() async {
    await cartStore.getCart(userStore.details.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localization = Localization.of(context);

    print('CartPage widget build()');
    return Scaffold(
      appBar: AwosheAppBar(title: localization.cart),
      backgroundColor: Colors.white,
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() =>
      Observer(
        builder: (context) {
          if (cartStore.cartFuture.status == FutureStatus.pending)
            return AwosheLoadingV2();

          if (!cartStore.hasResults || cartStore.isEmpty)
            return EmptyCart();

          if (cartStore.hasResults)
            return buildBody();

          return EmptyCart();
        },
      );

  // GIFT WIDGET
  Widget giftSection() =>
      Column(
        children: <Widget>[
          ExpansionTile(
            title: Text(localization.buyingGift, style: textStyle1),
            backgroundColor: Colors.white,
            children: <Widget>[
              Container(
                child: Text('What we have here?'),
              ),
            ],
//            trailing: StreamBuilder(
//              stream: bloc.isGiftExpandedStream,
//              builder: (context, snapshot){
//                return (snapshot.data) ?
//                Icon(
//                  Icons.keyboard_arrow_down,
//                  size: 28.0,
//                ) : Icon(Icons.keyboard_arrow_right, size: 28.0);
//              }
//            ),
            onExpansionChanged: (val) {},
          ),
        ],
      );

  Widget billingSection() {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(localization.itemsTotal)),
            Flexible(
              child: Observer(
                builder: (_) =>
                    Text(
                      "${userStore.details.currency} ${ PriceUtils.formatPriceToString(
                          cartStore.cartTotal)}",
                      style: textStyle1,
                    ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(localization.shipping)),
            Flexible(
              child: Text(
                'Shipping charge will be communicated by the designer',
                  textAlign: TextAlign.end,
//                "${userStore.details.currency} ${PriceUtils.formatPriceToString(cartStore.shippingCharge)}",
                style: textStyle1.copyWith(fontSize: 9.0),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(child: Text(localization.tax)),
            Flexible(
                child: Text(
                  "Import tax if any will be paid when you receive the item",
                  textAlign: TextAlign.end,
//                    "${userStore.details.currency} ${PriceUtils.formatPriceToString(cartStore.taxCharge)}",
                style: textStyle1.copyWith(fontSize: 9.0)))
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(localization.total)),
            Flexible(
              child: Observer(
                builder: (_) =>
                    Text(
                      "${userStore.details.currency} " +
                          PriceUtils.formatPriceToString(cartStore.totalBill),
                      style: textStyle2,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// FOOTER Checkout Button
  Widget checkout() => Container(
        height: 65.0,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: RoundedButton(
            buttonName: localization.completeYourOrder,
            onTap: () {
              Navigator.of(context, rootNavigator: false).push(
                CupertinoPageRoute<bool>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      Provider<OrderingStore>(
                        builder: (_) =>
                            OrderingStore(
                                cartStore.prepareUserOrder(
                                  userStore.details.currency
                                )
                            ),
                        child: OrderAddressInfoPage(),
                      ),
                ),
              );
//
            },
            buttonColor: primaryColor
        ),
  );

  Widget clearCartButton() => Container(
    height: 65.0,
    width: double.infinity,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
    child: RoundedButton(
        buttonName: 'Reset Cart',
        onTap: () {
          cartStore.clearCart(userId: userStore.details.id, userStore: userStore);
        },
        buttonColor: primaryColor
    ),
  );


  Widget buildBody() =>
      ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        children: <Widget>[
          CartItemTile(cartStore: cartStore, userStore: userStore,),
          SizedBox(height: 5.0),
          giftSection(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(height: 2.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: localization.submitOrderAdvice,
                    style: textStyleLight1,
                  ),
                  TextSpan(
                    text: localization.privacyPolicy,
                    style: TextStyle(
                        color: awLightColor,
                        fontFamily: 'Muli',
                        decoration: TextDecoration.underline,
                        fontSize: 14.0),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        AppRouter.router.navigateTo(
                            context, Routes.privacyPolicy,
                            transition: TransitionType.inFromRight);
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: billingSection(),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Divider(height: 1.0),
          ),
          SizedBox(height: 30.0),
          checkout(),
          SizedBox(height: 10.0),
          clearCartButton(),
          SizedBox(height: 70.0),
        ],
      );
}
