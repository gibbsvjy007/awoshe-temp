import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class FloatNextButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  final double radius;

  const FloatNextButton({Key key,
    @required this.title,
    this.radius = 25.0,
    this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(title, style: textStyle1.copyWith(color: Colors.white),
            textAlign: TextAlign.center,)),
        color: primaryColor,
        onPressed: onPressed
    );
  }
}
