import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/components/rating_bar/AwosheRatingBarV2.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';

class AppRatingDialog extends StatefulWidget {
  final ValueChanged<double> onConfirm;

  const AppRatingDialog({Key key,
    this.onConfirm}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppRatingDialog();

}

class _AppRatingDialog extends State<AppRatingDialog> {

  double rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0)),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Awoshe Review',)
      ],
    );
  }

  Widget _buildContent(){

    final margin = 10.0;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60.0,
            backgroundImage: AssetImage(Assets.awosheLogo),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: margin),
            child: Text('Awoshe', style: textStyle1,
              maxLines: 2,
              overflow:TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          AwosheRatingBarV2(
            color: primaryColor,
            allowHalfRating: true,
            editable: true,
            rating:  rating,
            starCount: 5,
            size: 42,
            borderColor: primaryColor,
            onRatingChanged: (rating) => this.rating = rating,
          ),

          Container(
            margin: EdgeInsets.only(top: margin * 2),
            child: Button(
              child: Text('Confirm'),
              onPressed: (){
                 if (widget.onConfirm !=null)
                  widget.onConfirm(rating);
              },
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),

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

}