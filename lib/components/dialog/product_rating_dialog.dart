import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/components/TextFieldPageRoute.dart';
import 'package:Awoshe/components/TextFields/AlwaysDisableFocusNode.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/text_field_page.dart';
import 'package:Awoshe/components/rating_bar/AwosheRatingBarV2.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';


typedef ProductRatingConfirm = void Function(double rating, String comments);

class ProductRatingDialog extends StatefulWidget {

  final String productTitle;
  final String productDesignerName;
  final String imageUrl;
  final double productAverage;
  final ProductRatingConfirm onConfirm;

  ProductRatingDialog({Key key,
    this.productTitle, this.imageUrl, this.productDesignerName,
    this.productAverage, this.onConfirm,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductRatingDialog();

}

class _ProductRatingDialog extends State<ProductRatingDialog>{

  TextEditingController controller;
  double rating = 3.5;

  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0)),
    );
  }


  Widget _buildTitle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Product Review',)
        //SvgIcon(Assets.designProducts, color: awBlack, size: 32,),
      ],
    );
  }

  Widget _buildContent(BuildContext context){

    final margin = 12.0;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(bottom: margin),
            height: 120,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      color: Colors.grey.withOpacity(.5),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AdvancedNetworkImage(
                          widget.imageUrl ?? PLACEHOLDER_DESIGN_IMAGE,
                          cacheRule: IMAGE_CACHE_RULE,
                          useDiskCache: true,
                        ),
                      ),
                    ),
                  ),
                ),

                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(widget.productTitle,
                          style: textStyle,
                          maxLines: 2,
                          overflow:TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),

                        Text('By: ${widget.productDesignerName ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle.copyWith(
                              color: awLightColor, fontSize: 12.0
                          ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: margin),
            child: AwosheRatingBarV2(
              color: primaryColor,
              allowHalfRating: true,
              editable: true,
              rating: rating,
              starCount: 5,
              size: 42,
              borderColor: primaryColor,
              onRatingChanged: (rating){ this.rating = rating; },
            ),
          ),

          commentsSection(context),

          Container(
            margin: EdgeInsets.only(top: margin),
            child: Button(
              child: Text('Confirm'),
              onPressed: (){
                if (widget.onConfirm != null){
                  widget.onConfirm(rating,controller.text);
                }
              },
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),

              // width: 120.0,
              width: 130.0,
              borderRadius: 24.0,
              height: 35.0,
              backgroundColor: primaryColor,
            ),
          ),

        ],
      ),
    );
  }

  Widget commentsSection(BuildContext context) => InputFieldV2(
    hintText: 'Review comments',
    obscureText: false,
    focusNode: AlwaysDisabledFocusNode(),
    onTap: (){
      Navigator.push(context,
        TextFieldPageRoute(
          page: TextFieldPage(
            title: 'Comments',
            initialText: controller.text,
            hint: 'Review comments',
            maxLines: 4,
            inputType: TextInputType.text,
            onDone: (data) {
              controller.text = data;
              Navigator.pop(context);
            },
            fieldDecoration: FieldDecoration.ROUNDED,
          ),
        ),
      );
    },
    hintStyle: TextStyle(color: awLightColor),
    textInputType: TextInputType.text,
    textStyle: textStyle,
    controller: controller,
    radius: APP_INPUT_RADIUS,
    leftPadding: 20.0,
    maxLines: 4,
    textFieldColor: textFieldColor,
    textAlign: TextAlign.left,
    bottomMargin: 15.0,

  );
}
