import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/components/rating_bar/AwosheRatingBarV2.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class DesignerRatingDialog extends StatefulWidget {

  final String designerName;
  final String imageUrl;
  final double designerAverage;
  final ValueChanged<double> onConfirm;

  const DesignerRatingDialog({Key key,
    this.designerName, this.imageUrl,
    this.designerAverage, this.onConfirm}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DesignerRatingDialogState();

}

class _DesignerRatingDialogState extends State<DesignerRatingDialog>{

  double score;

  @override
  void initState() {
    score = widget.designerAverage ?? 3.5;

    super.initState();
  }
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
        Text('Designer Review',)
      ],
    );
  }

  Widget _buildContent(){

    final margin = 10.0;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 60.0,
            backgroundImage:
            AdvancedNetworkImage(
              widget.imageUrl ?? PLACEHOLDER_PROFILE_IMAGE,
              cacheRule: IMAGE_CACHE_RULE,
              useDiskCache: true,
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: margin),
            child: Text(widget.designerName, style: textStyle1,
              maxLines: 2,
              overflow:TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          AwosheRatingBarV2(
            color: primaryColor,
            allowHalfRating: true,
            editable: true,
            rating: score,
            starCount: 5,
            size: 42,
            borderColor: primaryColor,
            onRatingChanged: (rating) => print('Current rating $rating'),
          ),

          Container(
            margin: EdgeInsets.only(top: margin * 2),
            child: Button(
              child: Text('Confirm'),
              onPressed: (){
                if (widget.onConfirm !=null)
                  widget.onConfirm(score);
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
