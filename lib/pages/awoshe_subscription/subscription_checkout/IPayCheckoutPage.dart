import 'package:Awoshe/models/order/subscription_order.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../logic/stores/subscription/subscription_store.dart';

class IPayCheckoutPage extends StatelessWidget {
  final SubscriptionOrder order;

  const IPayCheckoutPage({Key key,  @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var userStore = Provider.of<UserStore>(context);
    var orderingStore = Provider.of<SubscriptionStore>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(

          child: InAppWebView(
            initialData: InAppWebViewInitialData(
              data: orderingStore.paymentPage,
            ),
            initialOptions: InAppWebViewWidgetOptions(
              inAppWebViewOptions: InAppWebViewOptions(
                debuggingEnabled: true,

              )
          ),
          
          onJsAlert: (controller, data)  async {
            
            var status = await orderingStore.checkCurrentOrderStatus();
            switch(status){
              
              case InvoiceState.AWAITING_PAYMENT:
                print('Await payment');
                break;
              case InvoiceState.CANCELLED:
                Navigator.pop(context);
                return Future.value();
                break;
              case InvoiceState.EXPIRED:
                print('Order Expired');
                Navigator.pop(context);
                break;
              case InvoiceState.PAID:
                try {
                  print('Save in DB!');
                // store the order
                // clear the cart
                // go to thank you page.
                  //orderingStore.finishOrdering(context, userStore.details.id);
                  return JsAlertResponse()..handledByClient = true;
                } 
                
                catch(ex){
                  ShowFlushToast(context, 
                  ToastType.ERROR, 
                  ex.toString(),
                  callback: () => Navigator.pop(context),
                  );
                }
                break;

                
            }
            return Future.value();
          },

        ),
      ),
    ),
  );
  }
}