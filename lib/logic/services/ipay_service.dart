import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/ipay_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:flutter/foundation.dart';

class IPayService {

  Future<String> submitPayment( {
    @required String total,
    String currency,
    @required String invoiceId, }) async {

      Map<String, String> data = {
        IPayKeys.merchant_key: IPAY_KEY,
        IPayKeys.total: total,
        IPayKeys.currency: currency,
        IPayKeys.invoice_id: invoiceId,
      };

      try {
        var response = await IPayAPI.submitPayment(
          paymentData: data
        );
        
        print(response.content.toString() );
        return response.content;
      } 
      
      catch(ex){
        throw ex;
      }
  }

  Future<RestServiceResponse> checkStatus({@required String invoiceId}) async {

    try {
      return IPayAPI.statusCheck(invoiceId: invoiceId);
    } 
    
    catch (ex){
      throw ex;
    }
  }
}