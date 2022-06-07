import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:flutter/material.dart';

class OfferRequestChatItem extends StatelessWidget {

  final String productImage;
  final String productTitle;
  final String date;
  final String positiveActionLabel;
  final String negativeActionLabel;

  final VoidCallback positiveCallback;
  final VoidCallback negativeCallback;
  final bool hasMeasurements;
  final bool hasFabrics;
  final showActionsPanel;
  final String comments;

  const OfferRequestChatItem({Key key, this.productImage,
    this.productTitle, this.date,
    this.positiveActionLabel, this.negativeActionLabel,
    this.positiveCallback, this.negativeCallback,
    this.hasMeasurements, this.hasFabrics,
    this.comments, this.showActionsPanel = true}
    ) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final margin = 10.0;
    final phrase = 'Custom design with your selected';

    var size = MediaQuery.of(context).size;
    return Container(
      width:  size.width *.85,
      margin:EdgeInsets.all(8.0),
//      height: size.width * .7,
      decoration: BoxDecoration(
          color: awMessageWidgetColor,
          borderRadius: BorderRadius.circular(12)
      ),

      // main item column
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          // first section, product image, title and
          // request validation or received date
          Container(

            padding: EdgeInsets.all(margin),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //product image widget

                Container(
                  width: 60,
                  height: 80,
                  child: Image.network(
                    productImage ?? PLACEHOLDER_DESIGN_IMAGE,
                    fit: BoxFit.fill,
                  ),
                ),

                Flexible(
                    child: Text(
                      productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                ),

                Container(
                  height: 75,
                  width: 2,
                  color: awBlack.withOpacity(.1),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Approve by:',
                      textAlign: TextAlign.center,
                    ),

                    Text('$date',
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),

              ],
            ),
          ),

          optionSeparatorWidget(horizontalMargin: margin),

          // text sections
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            padding: EdgeInsets.all(margin),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  child: Text('Your Offer Includes:', maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: awBlack,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),

                (hasFabrics) ? Align(
                  child: Text('$phrase Fabric', maxLines: 2,),
                  alignment: Alignment.topLeft,
                ) : Container(),

                (hasMeasurements) ? Align(
                  child: Text('$phrase Measurements', maxLines: 2,),
                  alignment: Alignment.topLeft,
                ) : Container(),

                Align(
                  heightFactor: 1.0,
                  child: Text(comments ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,),
                  alignment: Alignment.topLeft,
                ),

              ],
            ),
          ),

          optionSeparatorWidget(horizontalMargin: margin),

          // buttons Section
          (showActionsPanel) ?
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed: negativeCallback,
                  child: Text('$negativeActionLabel'),
                ),

                RoundedButton(
                  height: 30,
                  buttonColor: primaryColor,
                  buttonName: '$positiveActionLabel',
                  borderWidth: .0,
                  onTap: positiveCallback,
                ),
              ],
            ),
          ) : Container(),
        ],
      ),
    );

  }
}
