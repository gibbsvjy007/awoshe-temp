import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/restclient/restclient.dart';
import 'package:Awoshe/utils/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// This class hold the request keys parameters to interact with
/// iPay payment Gateway.
class IPayKeys {

  /// REQUIRED: YES.
  /// 
  /// The value of merchant_key identifies the merchant who is using the gateway 
  /// It is usually obtained by registering for the iPay gateway service. 
  /// At the moment, registering for the iPay service is FREE.
  static const merchant_key = 'merchant_key';
  
  /// REQUIRED: YES.
  /// 
  /// A 25-character value that identifies the order. It must be unique!
  static const invoice_id = 'invoice_id';

  /// REQUIRED: YES.
  /// 
  /// The total payment due for the cart. 
  /// Please note that the gateway will NOT compute this. 
  /// We want the merchant to compute this him/herself and to add in any tax or shipping 
  /// elements they may want to. Future versions may compute this value if it 
  /// is not present but the current version does not.
  static const total = 'total';

  /// REQUIRED: NOT.
  /// 
  /// This specifies the url to which iPay will send notification once payment is received.
  static const ipn_url = 'ipn_url';

  /// REQUIRED: NOT.
  /// 
  /// The page to which iPay will redirect the user after user completes the iPay checkout process. 
  /// Please note that this does not mean that payment has been received!
  static const success_url = 'success_url';

  /// REQUIRED: NOT
  /// The page to which iPay will redirect the user after user cancels the order.
  static const cancelled_url = 'cancelled_url';

  /// REQUIRED: NOT.
  /// 
  /// The page to which iPay will redirect the user after user 
  /// chooses a payment option which allows deferred payments (eg in bank payments).
  static const deferred_url = 'deferred_url';


  /// REQUIRED: NOT.
  /// 
  /// Optional. Can be any of GHS, GBP, EUR or USD. 
  /// If provided, the total is considered to be in this currency. 
  /// Settlement currently occurs in GHS. This means, although, 
  /// you clients can pay in foreign currency, we currently can only transfer funds in GHS. 
  /// Another thing to note is using any other currency besides GHS, will disable all GHS 
  /// payment methods (this includes but is not limited to the mobile money payment methods). 
  /// Defaults to GHS.
  static const currency = 'currency';

  static const SUBMIT_ACTION_URL = "https://community.ipaygh.com/gateway";

  static const GET_STATUS_CHK  = 'https://community.ipaygh.com/v1/gateway/status_chk?$invoice_id={0}&$merchant_key={1}';
}


//https://community.ipaygh.com/v1/gateway/status_chk?invoice_id=AA123&merchant_key=YOUR_MERCHANT_KEY 

class IPayAPI {
  
  
  static Future<RestServiceResponse> submitPayment({
    @required Map<String, dynamic> paymentData, }) async {
      if (paymentData == null || paymentData.isEmpty)
        throw Exception('Invalid payment data');

      try {
        var response = RestClient.processHtmlResponse( 
          await http.post(IPayKeys.SUBMIT_ACTION_URL, body: paymentData)
          );
        
        if (!response.success)
          throw Exception(response.message);
        
        return response;
      }
      
      catch (ex){
        throw ex;
      }
    }
  
  static Future<RestServiceResponse> statusCheck({@required String invoiceId}) async {

    if (invoiceId == null || invoiceId.isEmpty)
      throw Exception('No Invoice ID');

    try  {
      
      String url = StringUtils.format(IPayKeys.GET_STATUS_CHK, [invoiceId, IPAY_TEST_MERCHANT_ID]);
      print('Checking $url');
      var response = RestClient.processHtmlResponse(await http.get(url));
      
      if (!response.success)
        throw Exception(response.message);

      return response;
    } 
    
    catch (ex){
      throw ex;
    }
  }
}

