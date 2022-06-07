import 'dart:io';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/carousel/carousel.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatefulWidget {
  final String productId;
  final List<String> productImages;
  final String productTitle;
  final String designerName;

  RatingPage(this.productId, {
    Key key,
    @required this.productImages,
    @required this.productTitle,
    @required this.designerName,
  }) : super(key: key);

  @override
  _RatingPageState createState() => new _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _productRating = 1;
  double _designerRating = 1;
  double _appRating = 1;
  TextEditingController _reviewController = new TextEditingController();
  UserStore userStore;

  @override
  initState() {
    super.initState();
    userStore = Provider.of<UserStore>(context, listen: false);
  }


  _handleProductRatingChanged(double _value) {
    setState(() {
      _productRating = _value;
    });
  }

  _handledesignerRatingChanged(double _value) {
    setState(() {
      _designerRating = _value;
    });
  }

  _handleAppRatingChanged(double _value) {
    setState(() {
      _appRating = _value;
    });
  }

  _showAlertDialog() {

    print('Review in ${widget.productId}');

    userStore.sendProductReview(
      widget.productId,
      productRating: _productRating,
      designerRating: _designerRating,
      experienceRating: _appRating,
      description: _reviewController.text,

    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            title: Center(child: Text('Thank You')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    '"If you don\'t like something, change it. '
                    'If you don\'t change it, change your attitude."',
                    style: lightText
                        .merge(TextStyle(fontStyle: FontStyle.italic))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Maya Angelo',
                        style: lightText
                            .merge(TextStyle(fontStyle: FontStyle.italic))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: AwosheButton(
                            width: 180.0,
                            childWidget: Text('Close', style: TextStyle(color: Colors.white),),
                            buttonColor: primaryColor,
                            onTap: () => Navigator.popUntil(context, ModalRoute.withName('ProductPage')),
                        ),
                      )
                    ])
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Color(0xff475E6D);
    final iconSize = 30.0;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ListView(children: <Widget>[
        Container(
          height: 250.0,
          child: Carousel(
            images:
                (widget.productImages.map<File>((path) => File(path)).toList()),
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: primaryColor,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            autoplay: false,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgIcon(
                    'assets/svg/design_products.svg',
                    color: iconColor,
                    size: iconSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                  Flexible(
                    child: Text(
                      '${widget.productTitle}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  )
                ],
              ),
              Row(children: <Widget>[
                StarRating(
                    rating: _productRating,
                    starCount: 5,
                    borderColor: Colors.black38,
                    color: Colors.yellow,
                    size: 50.0,
                    onRatingChanged: _handleProductRatingChanged),
              ]),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgIcon(
                    'assets/svg/designer.svg',
                    size: iconSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                  ),
                  Flexible(
                    child: Text(
                      'Designer: ${widget.designerName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                  )
                ],
              ),
              Row(children: <Widget>[
                StarRating(
                    rating: _designerRating,
                    starCount: 5,
                    borderColor: Colors.black38,
                    color: Colors.yellow,
                    size: 50.0,
                    onRatingChanged: _handledesignerRatingChanged),
              ]),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Icon(
                  Icons.phone_android,
                  size: iconSize,
                  color: iconColor,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                ),
                Flexible(
                  child: Text(
                    'Experience with the Awoshe App',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                )
              ]),
              Row(children: <Widget>[
                StarRating(
                    rating: _appRating,
                    starCount: 5,
                    borderColor: Colors.black38,
                    color: Colors.yellow,
                    size: 50.0,
                    onRatingChanged: _handleAppRatingChanged),
              ]),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                ),
                Text(
                  'Review of the ${widget.productTitle}',
                  style: textStyle,
                  textAlign: TextAlign.left,
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  top: 20.0,
                ),
                child: _reviewField(),
              ),
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 30.0),
          child: AwosheButton(
            buttonColor: primaryColor,

            childWidget: Text('Send', style: TextStyle(color: Colors.white),),
            onTap: _showAlertDialog,
          ),
        )
      ]),
    );
  }

  Widget _reviewField() => InputFieldV2(
        hintText: Localization.of(context).desc,
        obscureText: false,
        hintStyle: TextStyle(color: awLightColor),
        textInputType: TextInputType.text,
        textStyle: textStyle,
        controller: _reviewController,
        radius: APP_INPUT_RADIUS,
        leftPadding: 20.0,
        maxLines: 4,
        textFieldColor: textFieldColor,
        textAlign: TextAlign.left,
        bottomMargin: 15.0,
      );
}
