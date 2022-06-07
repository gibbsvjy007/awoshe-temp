import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = awDarkColor});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: textColor),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: 10.0, fontWeight: FontWeight.w600, color: awLightColor),
        ),
      ],
    );
  }
}
