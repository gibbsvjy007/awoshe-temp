import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class ProfileReviewTab extends StatefulWidget {
  ProfileReviewTab();

  @override
  _ProfileReviewTab createState() => new _ProfileReviewTab();
}

class _ProfileReviewTab extends State<ProfileReviewTab> {
  Widget reviewsWidget() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>[
        SizedBox(height: 20.0),
        const Text('Reviews', style: textStyle1),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.brightness_1,
            color: awLightColor,
            size: 14.0,
          ),
          title: Text('White V-Design T-Shirt with African Print',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: hintStyle),
        ),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.brightness_1,
            color: awLightColor,
            size: 14.0,
          ),
          title: Text('White V-Design T-Shirt with African Print',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: hintStyle),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: reviewsWidget());
  }
}
