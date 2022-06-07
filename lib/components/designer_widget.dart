import 'package:Awoshe/components/useravatar.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class DesignerInfo extends StatelessWidget {
  final String designerId;
  final String designerImage;
  final String designerName;
  final String designerRating;

  DesignerInfo({this.designerId, this.designerImage, this.designerName, this.designerRating});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(children: <Widget>[
                UserAvatar(
                  userId: designerId,
                  designerProfileImgUrl: designerImage,
                  fullName: designerName,
                  designerRating: designerRating ?? "4.0",
                )
              ]),
            ],
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    " by ",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    designerName,
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
