import 'package:Awoshe/components/dialog/app_rating_dialog.dart';
import 'package:Awoshe/components/dialog/designer_rating_dialog.dart';
import 'package:Awoshe/components/dialog/product_rating_dialog.dart';
import 'package:Awoshe/components/offer/OfferRequestChatItem.dart';
import 'package:Awoshe/components/review/ReviewChatItem.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/user_api.dart';
import 'package:Awoshe/logic/stores/chat/chat_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/creator/creator.dart';
import 'package:Awoshe/models/messages/message.dart';
import 'package:Awoshe/models/offer/Offer.dart';
import 'package:Awoshe/pages/product/product.page.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/DateUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// layout of the received message. we will show this messages to left side of the screen.
///
class ReceivedMessage extends StatelessWidget {
  ReceivedMessage({@required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        SizedBox(width: 10.0),

        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  padding: EdgeInsets.all(5.0),
                ),
            width: 35.0,
            height: 35.0,
//            imageUrl: message.receiverImage ?? PLACEHOLDER_PROFILE_IMAGE,
              fit: BoxFit.cover,
              imageUrl: message.sender.thumbnailUrl ??
                  'https://eu.ui-avatars.com/api/?name=' + message.receiver.name
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getMessageWidget(context),
              //message.messageType == MessageType.TEXT ?  :,
              buildTimeStamp()
            ],
          ),
        ),
      ],
    );
  }


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
    margin: EdgeInsets.only(left: 10.0),
  );

  Widget buildTextItem(String message) => Container(
    child: Text(
      message,
      style: TextStyle(fontSize: 14.0, color: secondaryColor, fontWeight: FontWeight.w500),
    ),
    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
    width: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.0),
    ),
  );

  Row buildTimeStamp() =>
      Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          child: Text(
            DateFormat('dd MMM kk:mm').format(message.createdOn),
            style: TextStyle(fontSize: 12.0, color: awLightColor),
          ),
          margin:
          EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0, bottom: 5.0),
        )
      ]);

  //
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

  Widget _createOfferChatItem(Offer offer, BuildContext context) {
    var type = message.messageType;
    var positiveLabel = (type == MessageType.OFFER) ? 'Approve' : 'Order now';
    var negativeLabel = 'No Thanks';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        (type == MessageType.OFFER) ? Container() :
        _buildSimpleTextWidget(message.message),


        OfferRequestChatItem(
          productTitle: offer.productName,
          productImage: offer.productImageUrl,
          date: DateUtils.formatDateToString(offer.deliveryDate),
          hasFabrics: offer.fabric,
          hasMeasurements: offer.measurement,
          positiveActionLabel: positiveLabel,
          negativeActionLabel: negativeLabel,
          //showActionsPanel: message.messageType == MessageType.APPROVED,
          comments: offer.comment,
          negativeCallback: () {},

          positiveCallback: () {
            Navigator.push(context, CupertinoPageRoute(
                builder: (_) => ProductPage(
                  viewMode: (type == MessageType.OFFER) ? ViewMode.CHECKING_OFFER : ViewMode.ORDERING_OFFER,
                  offer: offer,
                  productId: message.payload['product'],
                )
            )
            );
          },
        ),
      ],
    );
  }

  Widget _buildSimpleTextWidget(String message) =>
      Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: buildTextItem(message),
            ),
          ),
        ],
      );

  Widget _createReviewChatItem(BuildContext context) {

    Creator designer = Creator.fromJson(message.payload['designer']);
    String uid = Provider.of<UserStore>(context).details.id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        _buildSimpleTextWidget(message.message),


        ReviewChatItem(
          productTitle: message.payload['productTitle'],
          productImage: message.payload['productImageUrl'],
          designerTitle: designer?.name ?? '',
          designerImageUrl: designer?.thumbnailUrl,
          designerSubtitle: designer?.handle,
          date: DateUtils.formatDateToString(
              DateTime.fromMillisecondsSinceEpoch(message.payload['receivedOn'])
          ),

          // no Thanks callback
          onCancel: (){},
          onAppReview: () =>
              showDialog(
                  context: context,
                  builder: (_) =>
                      AppRatingDialog(onConfirm: (score) {
                        _sendAwosheReview(score, uid,
                            message.payload['productId'], context);
                        Navigator.pop(context);
                      },)
              ),

          onDesignerReview: () =>
              showDialog(
                  context: context,
                  builder: (_) =>
                      DesignerRatingDialog(
                        designerName: designer?.name ?? 'No name',
                        imageUrl: designer?.thumbnailUrl,
                        designerAverage: 3.5,
                        onConfirm: (score){
                          _sendDesignerReview(score, uid,
                              message.payload['productId'], context);
                          Navigator.pop(context);
                        },
                      )),

          onProductReview: () =>
              showDialog(context: context,
                builder: (_) =>
                    ProductRatingDialog(
                      imageUrl: message.payload['productImageUrl'],
                      productTitle: message.payload['productTitle'],
                      productDesignerName: designer?.name ?? '',
                      productAverage: 3.5,
                      onConfirm: (score, comments) {
                        Navigator.pop(context);

                        _sendProductReview(score, uid ,comments,
                            message.payload['productId'], context);
                      }
                    ),
              ),
        ),
      ],
    );
  }

  Widget getMessageWidget(BuildContext context) {

    var widget;

    print('___________ MSG TYPE IS ${message.id}');
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

      case MessageType.APPROVED:
      case MessageType.OFFER:
        widget = buildOfferItem(context);
        break;

      case MessageType.REVIEW:
        print('Review TYPE');
        widget = _createReviewChatItem(context);
        break;
    }

    return widget;
  }

  Future<void> _sendProductReview(double score, String uid, String comments,
      String productId, BuildContext context) async {

    return UserApi.submitProductReview(
        productId: productId,
        userId: uid,
        data: {"ratingDesc": comments, "productRating": score,}
    ).then((_){
      ShowFlushToast(context, ToastType.SUCCESS,
          'Thanks for your feedback.');
    }).catchError( (_){
      ShowFlushToast(context, ToastType.ERROR,
          'Was not possible send your feedback' );
    } );
  }

  Future<void> _sendDesignerReview(double score, String uid,
      String productId, BuildContext context) async {

    return UserApi.submitProductReview(
        productId: productId,
        userId: uid,
        data: {"designerRating": score,}
    ).then((_){
      ShowFlushToast(context, ToastType.SUCCESS,
          'Thanks for your feedback.');
    }).catchError( (_){
      ShowFlushToast(context, ToastType.ERROR,
          'Was not possible send your feedback' );
    } );
  }

  Future<void> _sendAwosheReview(double score, String uid,
      String productId, BuildContext context) async {

    return UserApi.submitProductReview(
        productId: productId,
        userId: uid,
        data: {"experienceRating": score,}
    ).then((_){
      ShowFlushToast(context, ToastType.SUCCESS,
          'Thanks for your feedback.');
    }).catchError( (_){
      ShowFlushToast(context, ToastType.ERROR,
          'Was not possible send your feedback' );
    } );
  }
}
