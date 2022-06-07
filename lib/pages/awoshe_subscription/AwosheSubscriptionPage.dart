import 'package:Awoshe/components/plan/PlanItem.dart';
import 'package:Awoshe/logic/stores/subscription/subscription_store.dart';
import 'package:Awoshe/pages/awoshe_subscription/subscription_checkout/IPayCheckoutPage.dart';
import 'package:Awoshe/pages/awoshe_subscription/subscription_checkout/StripeCheckoutPage.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../components/closefab.dart';
import '../../constants.dart';
import '../../logic/stores/currency/currency_store.dart';
import '../../logic/stores/user/user_store.dart';
import '../../theme/theme.dart';
import '../../utils/PriceUtils.dart';
import '../../utils/flush_toast.dart';


class AwosheSubscriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AwosheSubscriptionPageState();
}

class _AwosheSubscriptionPageState extends State<AwosheSubscriptionPage> {
  SubscriptionStore store;
  UserStore userStore;
  CurrencyStore currencyStore;

  @override
  void initState() {
    currencyStore = Provider.of<CurrencyStore>(context, listen: false);
    store = SubscriptionStore(currencyStore);
    store.loadData();
    userStore = Provider.of<UserStore>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AwosheCloseFab(
        onPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: <Widget>[

          Observer(
            builder: (_) {
              if (store.status == DataStatus.LOADING) 
                return loadWidget();

              if (store.status == DataStatus.ERROR)
                return errorWidget();

              if (store.planList.isEmpty)
                return errorWidget();
              
              return buildCarousel();
            },
          ),

          Observer(
            builder: (_) =>  
              store.iPayCheckoutStatus == CheckoutStatus.DOING 
              ? ModalAwosheLoading() 
              : Container(),
          ),
        ],
      ),
    );
  }

  Widget loadWidget() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: AwosheLoadingV2(),
          ),
        ],
      );

  Widget buildCarousel() {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Center(
          child: CarouselSlider(
            items: createCarouselWidgets(size),
            autoPlay: false,
            initialPage: 1,
            height: size.height * .7,
            enlargeCenterPage: true,
            viewportFraction: .85,
          ),
        ),
      ],
    );
  }

  Widget errorWidget() => Column(
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Center(
        child: Text('Was not possible fetch the data.', style: textStyle1),
      ),
    ],
  );

  List<Widget> createCarouselWidgets(Size size) {
    return store.planList
        .map((plan) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PlanItem(
                title: plan.nickname,
                price: priceToString(plan.amount, plan.currency),
                features: plan.metadata.include?.split(',') ?? [''],
                period: plan.interval,
                onCheckout: () async {
                  // if GHS checkout with iPay
                  if (userStore.details.currency == CURRENCIES[1]) {
                    store.createSubscriptionOrderWithIPay(
                      plan: plan,
                      uid: userStore.details.id,
                      userCurrency: userStore.details.currency,
                      userEmail: userStore.details.email,
                    ).then((_) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => Provider<SubscriptionStore>(
                            builder: (_) => this.store,
                            child: IPayCheckoutPage(
                              order: store.createSubscriptionOrder(
                                  plan,userStore.details.id,
                                  userStore.details.currency),
                            ),
                          ),
                        ),
                      );
                    }).catchError((err) { ShowFlushToast(context, ToastType.ERROR, err.toString()); });
                  } 
                  
                  else {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => Provider<SubscriptionStore>(
                            builder: (_) => this.store,
                            child: StripeCheckoutPage(
                                store.createSubscriptionOrder(
                                    plan,
                                    userStore.details.id,
                                    userStore.details.currency)),
                          ),
                        ));
                  }
                },
              ),
            ))
        .toList();
  }

  String priceToString(int amount, String planCurrency) {
    var price = store.handlePrice(amount, planCurrency.toUpperCase(),
        userStore.details.currency.toUpperCase());

    return '${userStore.details.currency} ${PriceUtils.formatPriceToString(price)}';
  }

}
