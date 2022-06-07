import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/logic/stores/ordering/ordering_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/order/submit.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:provider/provider.dart';
import 'shipping.dart';

class OrderAddressInfoPage extends StatefulWidget {

  @override
  OrderAddressInfoPageState createState() => new OrderAddressInfoPageState();
}

class OrderAddressInfoPageState extends State<OrderAddressInfoPage> {
  UserStore _userStore;
  OrderingStore orderingStore;

  @override
  void didChangeDependencies() {
    _userStore ??= Provider.of<UserStore>(context);
    orderingStore ??= Provider.of<OrderingStore>(context);

    orderingStore.setShippingAddress(_userStore.details.address1);
    orderingStore.setBillingAddress(_userStore.details.address2);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Address Info'),
          elevation: 0.0,
          leading: IconButton(
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              icon: Icon(CupertinoIcons.back, color: Colors.black,),
          ),

        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 16.0),
            color: Colors.white,
              child: Column(
                children: <Widget>[
                  ShippingOrder(),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    child: AwosheButton(
                        childWidget: Text("Continue", style: buttonTextStyle),
                        onTap: () {
                          orderingStore.setShippingAddress(
                              _userStore.details.address1);
                          orderingStore.setBillingAddress(
                              _userStore.details.address2);

                          orderingStore.validateAddress()
                              ? openSubmitOrderPage()
                              :
                          ShowFlushToast(context, ToastType.WARNING,
                              'You must provide both shipping and billing addresses'
                          );
                        },
                        width: double.infinity,
                        height: 50.0,
                        buttonColor: primaryColor
                    ),
                  ),
                ],
              ),
          ),
        ),

    );
  }

  void openSubmitOrderPage() =>
      Navigator.push(context,
        CupertinoPageRoute(
          builder: (context) =>
              Provider<OrderingStore>(
                child: SubmitOrderPage(),
                builder: (_) => orderingStore,
              ),
        ),
      );
}
