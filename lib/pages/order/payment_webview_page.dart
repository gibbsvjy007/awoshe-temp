import 'package:Awoshe/logic/stores/ordering/ordering_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class PaymentWebViewPage extends StatelessWidget {
  final String data;
  final OrderingStore orderingStore;

  const PaymentWebViewPage({Key key, @required this.data, @required this.orderingStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(

          child: InAppWebView(
            initialData: InAppWebViewInitialData(
              data: data,
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
                  orderingStore.finishOrdering(context, userStore.details.id);
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