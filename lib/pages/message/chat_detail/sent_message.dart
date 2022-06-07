import 'package:Awoshe/components/offer/OfferRequestChatItem.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/chat/chat_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/DateUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// layout for a message sent by the user. right aligned to the screen
class SentMessage extends StatelessWidget {
  SentMessage({@required this.message});

  final Message message;

  Widget buildImageItem() => Container(
        child: Material(
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              width: 150.0,
              height: 150.0,
              padding: EdgeInsets.all(60.0),
              decoration: BoxDecoration(
                color: awLightColor300,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Material(
              child: Image.asset(
                Assets.imgNotAvailable,
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              clipBehavior: Clip.hardEdge,
            ),
            imageUrl: message.message,
            width: 150.0,
            height: 150.0,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          clipBehavior: Clip.hardEdge,
        ),
        margin: EdgeInsets.only(right: 10.0),
      );

  Widget buildTextItem(String message) => Container(
        child: Text(
          message ?? '',
          style: TextStyle(
              fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        width: 200.0,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        margin: EdgeInsets.only(right: 10.0),
      );

  Row buildTimeStamp() =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Container(
          child: Text(
            DateFormat('dd MMM kk:mm').format(message.createdOn),
            style: TextStyle(fontSize: 12.0, color: awLightColor),
          ),
          margin:
              EdgeInsets.only(left: 0.0, right: 15.0, top: 5.0, bottom: 5.0),
        )
      ]);

  Widget buildOfferItem(BuildContext context) {
    final chatStore = Provider.of<ChatStore>(context);
    var userStore = Provider.of<UserStore>(context, listen: false);

    final offerId = message.payload['offer'];

    // verifying if the offer message was stored in cache.
    if (chatStore.offersCache.containsKey(message.id))
      return _createOfferChatItem(chatStore.offersCache[message.id], context );

    else {
      final id =  userStore.details.id;
      var future = (message.messageType == MessageType.OFFER)
          ? userStore.offerService.getOfferDetailsRequest(
        userId: id,
        offerId: offerId,
        designerId: message.receiver.id,)

          : userStore.offerService.getOfferDetailsApprove(
          userId: id,
          offerId: offerId,
          designerId: message.sender.id
      );

      return FutureBuilder<Offer>(
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Offer unavailable');

          if (snapshot.connectionState == ConnectionState.done) {
            var offer = snapshot.data;

            // adding offer to cache
            chatStore.addOffer(message.id, offer);
            return _createOfferChatItem(offer, context);
          }

          else
            return AwosheLoadingV2();
        },

        future: future,
      );
    }
  }

  Widget _createOfferChatItem(Offer offer, BuildContext context) => OfferRequestChatItem(
    productTitle: offer.productName,
    productImage: offer.productImageUrl,
    date: DateUtils.formatDateToString(offer.deliveryDate),
    hasFabrics: offer.fabric,
    hasMeasurements: offer.measurement,
    comments: offer.comment,
    showActionsPanel: false,
  );

  Widget _createReviewChatItem(BuildContext context) => Container();

  Widget getMessageWidget(BuildContext context) {

    var widget;
    switch(message.messageType){

      case MessageType.TEXT:
        widget = buildTextItem(message.message);
        break;

      case MessageType.IMAGE:
        widget = buildImageItem();
        break;

      case MessageType.EMOJI:
        widget = Container();
        break;

      case MessageType.OFFER:
        widget = buildOfferItem(context);
        break;

      case MessageType.REVIEW:
        print('Review TYPE');
        widget = _createReviewChatItem(context);
        break;
      case MessageType.APPROVED:
        print('Sent message');
        widget = buildOfferItem(context);
        break;
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              getMessageWidget(context),
              buildTimeStamp(),
            ],
          ),
        )
      ],
    );
  }
}
