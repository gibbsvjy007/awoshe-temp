import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class TextAreaInput extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final Color textFieldColor, iconColor;
  final bool obscureText;
  final double bottomMargin;
  final TextStyle textStyle, hintStyle;
  final Function validateFunction;
  final Function onSaved;
  final Color borderColor;
  final TextEditingController controller;
  final String floatingLabel;
  final Key key;
  final TextAlign textAlign;
  final int maxLines;
  final double borderRadius;
  //passing props in the Constructor.
  //Java like style
  TextAreaInput(
      {this.key,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.textFieldColor,
      this.icon,
      this.iconColor,
      this.bottomMargin,
      this.textStyle,
      this.textAlign,
      this.validateFunction,
      this.borderColor,
      this.onSaved,
      this.floatingLabel,
      this.controller,
      this.borderRadius,
      this.hintStyle,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: borderRadius != null
                  ? BorderRadius.all(Radius.circular(borderRadius))
                  : BorderRadius.all(Radius.circular(20.0)),
              border: borderColor == null
                  ? Border.all(color: awLightColor)
                  : Border.all(color: borderColor),
              /*border: Border(
                  bottom: BorderSide(
                color: awLightColor,
              )),*/
              color: textFieldColor),
          child: TextFormField(
            style: textStyle,
            key: key,
            obscureText: obscureText,
            keyboardType: textInputType,
            validator: validateFunction,
            maxLines: maxLines,
            controller: controller,
            textAlign: textAlign != null ? this.textAlign : TextAlign.left,
            onSaved: onSaved,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              errorStyle: TextStyle(color: Colors.redAccent),
              contentPadding: floatingLabel != null
                  ? EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0)
                  : EdgeInsets.only(bottom: 15.0, top: 15.0, left: 10.0),
              fillColor: Colors.white70,
              filled: false,
              labelText: floatingLabel,
              border: InputBorder.none,
            ),
          ),
        )));
  }
}
