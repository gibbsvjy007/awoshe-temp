import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/WidgetUtils.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class ReviewChatItem extends StatelessWidget {

  final String productImage;
  final String productTitle;
  final String date;
  final String designerTitle, designerSubtitle, designerImageUrl;
  final VoidCallback onProductReview, onDesignerReview,
      onAppReview, onCancel;
  final margin = 12.0;
  final spacing = 8.0;
  final double radius = 30;

  const ReviewChatItem({Key key,
    this.productImage, this.productTitle, this.date,
    this.designerTitle, this.designerSubtitle, this.onCancel,
    this.onProductReview, this.onDesignerReview,
    this.designerImageUrl, this.onAppReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width:  size.width *.85,
      margin:EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: awMessageWidgetColor,
          borderRadius: BorderRadius.circular(12)
      ),

      // main item column
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          _buildProduct(title: '$productTitle',
            buttonText: 'Product Review',
            imageUrl: productImage ?? PLACEHOLDER_DESIGN_IMAGE,
            onTap: onProductReview,
            date: date,
          ),

          optionSeparatorWidget(horizontalMargin: margin),

          _defaultSection(title: '$designerTitle',
              subtitle: designerSubtitle,
              imageUrl: designerImageUrl,
              onTap: onDesignerReview,
              buttonText: 'Designer Review'
          ),

          optionSeparatorWidget(horizontalMargin: margin),

          _defaultSection(title: 'Experience with Awoshe App',
            imageUrl: Assets.awosheLogo, assetImage: true,
            buttonText: 'Review App', onTap: onAppReview,
          ),

          optionSeparatorWidget(horizontalMargin: margin),

          FlatButton(
              onPressed: onCancel,
              child: Text('No Thanks')
          ),

        ],
      ),
    );
  }

  Widget _buildProduct({String title, String imageUrl,
    String date, VoidCallback onTap, String buttonText,}){

    return Container(

      padding: EdgeInsets.all(margin),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //product image widget
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  width: 60,
                  height: 80,
                  child: Image(
                    image: AdvancedNetworkImage(
                      productImage ?? PLACEHOLDER_DESIGN_IMAGE,
                      useDiskCache: true,
                      cacheRule: IMAGE_CACHE_RULE,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Container(width: spacing,),

              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Container(width: spacing ,),

              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  'Received on $date',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              child: RoundedButton(
                height: 30,
                width: 130,
                buttonColor: primaryColor,
                buttonName: '$buttonText',
                borderWidth: .0,
                onTap: onTap,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _defaultSection({String title, String buttonText,
    String subtitle, String imageUrl, VoidCallback onTap,bool assetImage = false }) {
    return Container(

      padding: EdgeInsets.all(margin),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //product image widget
              CircleAvatar(
                radius: radius,
                backgroundColor: Colors.white,
                backgroundImage: (assetImage == true)
                    ? AssetImage(imageUrl)
                    : AdvancedNetworkImage(
                        imageUrl ?? PLACEHOLDER_PROFILE_IMAGE,
                        cacheRule: IMAGE_CACHE_RULE,
                        useDiskCache: true,
                      ),
              ),

              Container(width: spacing,),

              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '$title',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.max,
                    ),

                    (subtitle != null)  ? Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      mainAxisSize: MainAxisSize.max,
                    ) : Container(),

                  ],
                ),
              ),

            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(top: 28.0),
              child: RoundedButton(
                height: 30,
                width: 140,
                buttonColor: primaryColor,
                buttonName: buttonText,
                borderWidth: .0,
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
