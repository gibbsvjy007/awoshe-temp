import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/stripe_api.dart';
import 'package:Awoshe/logic/services/ipay_service.dart';
import 'package:Awoshe/logic/services/order_service_v2.dart';
import 'package:Awoshe/logic/stores/cart/cart_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/order/payment.dart';
import 'package:Awoshe/pages/order/order_done.dart';
import 'package:Awoshe/utils/PriceUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:stripe_sdk/src/stripe_error.dart';
part 'ordering_store.g.dart';

class OrderingStore = _OrderingStore with _$OrderingStore;

abstract class _OrderingStore with Store {
  bool isLocal = true;

  final OrderServiceV2 _service = OrderServiceV2();

  @observable
  Order order;

  @observable
  CheckoutStatus checkoutStatus = CheckoutStatus.NONE;

  @observable
  String checkoutErrorMsg;

  @observable
  PaymentMethod paymentType = PaymentMethod.CARD;

  _OrderingStore(Order order) : order = order;

  String paymentPage;

  String currentInvoiceId;

  @action
  void setPaymentMethod(PaymentMethod type) {
    paymentType = type;
    order.paymentMethod = paymentType.index;
  }

  @action
  void setShippingAddress(Address addr) => order.shippingAddress = addr;

  @action
  void setBillingAddress(Address addr) => order.billingAddress = addr;

  @action
  void setCheckoutStatus(CheckoutStatus status) => checkoutStatus = status;

  @action
  void setCheckoutErrorMsg(String msg) => checkoutErrorMsg = msg;

  // ===== end of actions

  bool validateAddress() =>
      ((order.shippingAddress != null) && (order.billingAddress != null));



  InvoiceState _parseIPayResponse(String response) {
      var data = response.split('~');
      
      if (data[1] == 'paid')
        return InvoiceState.PAID;

      if (data[1] == 'expired')
        return InvoiceState.EXPIRED;
      
      if (data[1] == 'cancelled')
        return InvoiceState.CANCELLED;

      if (data[1] == 'awaiting_payment')  
        return InvoiceState.AWAITING_PAYMENT;

  }     

  Future<InvoiceState> checkCurrentOrderStatus() async {
    try {
      final IPayService service = IPayService();
      var response = await service.checkStatus(invoiceId: currentInvoiceId);
      print('SUCCESS');
      return _parseIPayResponse(response.content);
      
    } 
    
    catch (ex){
      print(ex);
      throw Exception(ex.toString());
    } 
  }

  // using IPay payment
  Future<void> createNewOrder( {@required String uid, @required String currency, String userEmail}) async {

    try {
      setCheckoutStatus(CheckoutStatus.DOING);
      currentInvoiceId = await _fetchAccessCodeFrmServer();
      final IPayService service = IPayService();
      var total = PriceUtils.formatPriceToString(order.total)
      .replaceAll(',', '');

      paymentPage = await service.submitPayment(
        invoiceId: currentInvoiceId,
        total: total,
        currency: currency,
      );
      
      setCheckoutStatus(CheckoutStatus.COMPLETE);
    } 
    
    catch( ex ){
      currentInvoiceId = null;
      setCheckoutStatus(CheckoutStatus.ERROR);
      setCheckoutErrorMsg(ex.toString() );
      throw ex;
    }
  }

  Future<void> orderingWithStripe(StripeCard card, String uid, String currency) async {
    try {
      setCheckoutStatus( CheckoutStatus.DOING );
      Stripe.init(PAYSTRIPE_TEST_KEY);
      StripeApi.init(PAYSTRIPE_TEST_KEY);
      
      var amount = (order.total * 100).toString().split('.')[0]; 
      //print(amount);     
      
      var serverResponse = await StripePaymentApi.createPaymentIntent(
        uid: uid,
        amount: amount,
        currency: currency.toLowerCase(),
      );

      var secret = serverResponse.content['client_secret'];
      var paymentMethod = await StripeApi.instance.createPaymentMethodFromCard(card);
      var paymentIntent = await Stripe.instance.confirmPayment(secret, paymentMethod['id']);
      
      //4000 0000 0000 0341
      print('DATA CONFIRMED $paymentIntent');
      if (paymentIntent['status'] != 'succeeded'){
        var error = 'Payment Failed';
        setCheckoutErrorMsg( error );
        setCheckoutStatus( CheckoutStatus.ERROR );
        throw error;
      }
        
      setCheckoutStatus( CheckoutStatus.COMPLETE );
      return;
    } 
    on StripeAPIException catch (ex){
      print(ex);
      setCheckoutErrorMsg( ex.message );
      setCheckoutStatus( CheckoutStatus.ERROR );
      
      throw ex;
    }

  }
  
  Future<String> _fetchAccessCodeFrmServer() async {
    if (isLocal) return _getReference();

    String url = '$PAYSTACK_BACKEND_URL_TEST/new-access-code';
    String accessCode;

    try {
      http.Response response = await http.get(url);
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      print('There was a problem getting a new access code form'
          ' the backend: $e');

      throw Exception('There was a problem getting a new access code form '
          'the backend: $e');
    }
    return accessCode;
  }

  Future<void> _storeOrderOnDatabase(
      String reference, String uid) async {
    /// if the transaction is successful then delete the items from the cart and create an order
    /// for the designer
    /// Trigger the cloud function for notifying the designer
    /// Attach the payment information with order
    Payment _payment = Payment(
      paymentMethod: order.paymentMethod,
      referenceId: reference,
    );

    order.payment = _payment;
    order.invoiceId = reference;
    try {
      await _service.createOrder(userId: uid, order: order);
    } catch (ex) {
      throw Exception("Error when upload the order");
    }
  }

  String _getReference() => '${DateTime.now().millisecondsSinceEpoch}';

  void finishOrdering(BuildContext context, String userId) async {
    
    try {
      await _storeOrderOnDatabase(currentInvoiceId, userId);  
      /// once order is done lets clear the cart and delete all the items.
      CartStore cartStore = Provider.of<CartStore>(context);
      UserStore userStore = Provider.of<UserStore>(context);
      cartStore.clearCart(userId: userId, userStore: userStore);

      Navigator.push(context, CupertinoPageRoute(
          builder: (_) => OrderDone())
      );
    } 
    catch (ex){
      throw ex;
    }
  }
}