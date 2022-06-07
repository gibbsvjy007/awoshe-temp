
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class NoDataAvailable extends StatelessWidget {
  final String message;

  NoDataAvailable({
    this.message = "No Data Available"
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0),
            SvgIcon(Assets.sad, size: 150.0, color: awLightColor,),
            SizedBox(height: 20.0),
            Text(
              message,
              style: TextStyle(fontSize: 18.0, color: awLightColor),
            )
          ],
        ),
      ),
    );
  }
}
