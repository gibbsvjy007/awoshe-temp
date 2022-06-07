import 'package:Awoshe/logic/api/offer_api.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:flutter/foundation.dart';

class OfferService {

  /// this method creates a new offer request.
  Future<void> requestAnOffer({@required String userId,
    @required String productId,
    @required Offer offer,
  } ) async {

    try {

      await OfferApi.createOffer(userId: userId,
            productId: productId, data: offer.toJson(),
        );

     // return Offer.fromJson( data );

    }
    catch (ex){
      throw ex;
    }
  }

  Future<void> approveOffer({@required String productId,
    @required String userId, @required Offer offer }) async {

    try {
      await OfferApi.approveOffer(
          userId: userId, productId: productId, data: offer.toJson());
      return;
    }
    catch (ex){
      throw ex;
    }
  }

  Future<Offer> getOfferDetailsRequest({@required String userId,
    @required String offerId, @required String designerId}) async {

    try {
      var data = await OfferApi.getOfferRequest(userId: userId,
          offerId: offerId, designerId: designerId);

      return Offer.fromJson(data);
    }
    catch (ex){
      throw ex;
    }
  }

  Future<Offer> getOfferDetailsApprove({@required String userId,
    @required String offerId, @required String designerId}) async {

    try {
      var data = await OfferApi.getOfferApprove(userId: userId,
          offerId: offerId, designerId: designerId);

      return Offer.fromJson(data);
    }
    catch (ex){
      print(ex);
      throw ex;
    }
  }
}