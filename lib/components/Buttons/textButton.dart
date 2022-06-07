import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class TextButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final bool shouldUnderlined;
  final TextStyle buttonTextStyle;
  //passing props in react style
  TextButton(
      {this.buttonName,
      this.onPressed,
      this.buttonTextStyle,
      this.shouldUnderlined = false});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(buttonName,
          textAlign: TextAlign.center,
          style: (this.shouldUnderlined != null && this.shouldUnderlined)
              ? buttonTextWithUnderlineStyle
              : this.buttonTextStyle),
      onPressed: onPressed,
    );
  }
}
