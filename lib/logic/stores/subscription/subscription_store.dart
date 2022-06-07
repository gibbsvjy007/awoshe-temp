import 'package:Awoshe/models/order/subscription_order.dart';
import 'package:Awoshe/models/plan/Plan.dart';
import 'package:Awoshe/services/awoshe_plans_service.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/src/stripe_error.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import '../../../constants.dart';
import '../../api/stripe_api.dart';
import '../../services/ipay_service.dart';
import '../currency/currency_store.dart';

part 'subscription_store.g.dart';

class SubscriptionStore = _SubscriptionStore with _$SubscriptionStore;

enum DataStatus {LOADING, LOADED, ERROR}
abstract class _SubscriptionStore with Store {

  _SubscriptionStore(this.currencyStore);

  final PlanService _service = PlanService();

  final CurrencyStore currencyStore;

  @observable
  DataStatus status;

  List<Plan> planList = [];

  SubscriptionOrder order;

  @observable
  CheckoutStatus iPayCheckoutStatus;

  @observable
  CheckoutStatus stripeCheckoutStatus;

  @observable
  InvoiceState invoiceState;

  String currentInvoiceId;

  String paymentPage;

  bool isLocal = true;


  @action
  void setStripeCheckoutStatus(CheckoutStatus s) => stripeCheckoutStatus = s;

  @action
  void setStatus(DataStatus flag ) => status = flag;

  @action
  void setIpayCheckoutStatus(CheckoutStatus status) => iPayCheckoutStatus = status;

  void loadData() async {
    if (status == DataStatus.LOADING)
      return;

    try {
      setStatus(DataStatus.LOADING);
      planList = await _service.getAllPlans();
      setStatus(DataStatus.LOADED);
    }

    catch (ex){
      print('SubscriptionStore::loadData $ex');
      setStatus(DataStatus.ERROR);
    }
  }

  SubscriptionOrder createSubscriptionOrder(Plan plan, String userId, String userCurrency) {
    return SubscriptionOrder(
      amount: (handlePrice(plan.amount, plan.currency, userCurrency) * 100 ).round(),
      currency: userCurrency,
      plan: plan,
      designerId: userId

    );
  }

  double handlePrice(int amount, String currency, String userCurrency){
    double price = amount / 100;

    if (currency != userCurrency){
      price = price * currencyStore.getExchangeRate(
        from: currency, 
        to: userCurrency
      );
    }

    return price;

  }

  // using IPay payment
  Future<void> createSubscriptionOrderWithIPay( {
    String uid,
    Plan plan,
    String userCurrency,
    String userEmail}) async {

    try {
      setIpayCheckoutStatus(CheckoutStatus.DOING);
      currentInvoiceId = await _fetchAccessCodeFrmServer();
      final IPayService service = IPayService();
      var total = handlePrice(plan.amount, plan.currency, userCurrency);

      paymentPage = await service.submitPayment(
        invoiceId: currentInvoiceId,
        total: total.toString(),
        currency: userCurrency,
      );
      
      setIpayCheckoutStatus(CheckoutStatus.COMPLETE);
    } 
    
    catch( ex ){
      currentInvoiceId = null;
      setIpayCheckoutStatus(CheckoutStatus.ERROR);
      //setCheckoutErrorMsg(ex.toString() );
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

  
  String _getReference() => '${DateTime.now().millisecondsSinceEpoch}';

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

  Future<void> orderingWithStripe({StripeCard card,
    Plan plan,
      String uid, String userCurrency}) async {
    try {
      setStripeCheckoutStatus( CheckoutStatus.DOING );
      Stripe.init(PAYSTRIPE_TEST_KEY);
      StripeApi.init(PAYSTRIPE_TEST_KEY);

      var amount = (handlePrice(plan.amount, plan.currency, userCurrency) * 100).round();
      //print(amount);

      var serverResponse = await StripePaymentApi.createPaymentIntent(
        uid: uid,
        amount: amount.toString(),
        currency: userCurrency.toLowerCase(),
      );
//
      var secret = serverResponse.content['client_secret'];
      var paymentMethod = await StripeApi.instance.createPaymentMethodFromCard(card);
      var paymentIntent = await Stripe.instance.confirmPayment(secret, paymentMethod['id']);

      //4000 0000 0000 0341
      print('DATA CONFIRMED $paymentIntent');
      if (paymentIntent['status'] != 'succeeded'){
        var error = 'Payment Failed';

        setStripeCheckoutStatus( CheckoutStatus.ERROR );
        throw error;
      }

      setStripeCheckoutStatus( CheckoutStatus.COMPLETE );
      return;
    }
    on StripeAPIException catch (ex){
      print(ex);
//      setCheckoutErrorMsg( ex.message );
      setStripeCheckoutStatus( CheckoutStatus.ERROR );

      throw ex;
    }

  }
}