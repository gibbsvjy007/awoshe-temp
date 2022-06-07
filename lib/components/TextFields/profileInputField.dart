import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class ProfileInputField extends StatelessWidget {
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
  //passing props in the Constructor.
  //Java like style
  ProfileInputField(
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
      this.hintStyle,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: DecoratedBox(
          decoration: BoxDecoration(
              /* borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: borderColor == null
                  ? Border.all(color: awLightColor)
                  : Border.all(color: borderColor),*/
              border: Border(
                  bottom: BorderSide(
                color: awLightColor,
              )),
              color: textFieldColor),
          child: CupertinoTextField(
            style: textStyle,

            key: key,
            obscureText: obscureText,
            keyboardType: textInputType,
            //validator: validateFunction,
            maxLines: maxLines,
            controller: controller,
            textAlign: textAlign != null ? this.textAlign : TextAlign.left,
            //onSaved: onSaved,
            /*decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              errorStyle: TextStyle(color: Colors.redAccent),
              contentPadding: floatingLabel != null
                  ? EdgeInsets.only(left: 30.0, top: 10.0, bottom: 10.0)
                  : EdgeInsets.only(bottom: 15.0, top: 15.0, left: 10.0),
              fillColor: Colors.white70,
              filled: false,
              labelText: floatingLabel,
              border: InputBorder.none,
            ),*/
          ),
        )));
  }
}

class InputFieldWithIcon extends StatelessWidget {
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
  InputFieldWithIcon(
      {this.key,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.textFieldColor,
      this.icon,
      this.iconColor,
      this.bottomMargin,
      this.textStyle,
      this.validateFunction,
      this.borderColor,
      this.onSaved,
      this.floatingLabel,
      this.controller,
      this.hintStyle});

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: borderColor == null
                  ? Border.all(color: awLightColor)
                  : Border.all(color: borderColor),
              color: textFieldColor),
          child: TextFormField(
            style: textStyle,
            key: key,
            obscureText: obscureText,
            keyboardType: textInputType,
            validator: validateFunction,
            controller: controller,
            textAlign: TextAlign.center,
            onSaved: onSaved,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,
                errorStyle: TextStyle(color: Colors.redAccent),
                contentPadding: floatingLabel != null
                    ? EdgeInsets.only(left: 30.0, top: 10.0, bottom: 10.0)
                    : EdgeInsets.only(bottom: 15.0, top: 15.0, left: 10.0),
                fillColor: Colors.white70,
                filled: false,
                labelText: floatingLabel,
                border: InputBorder.none,
                icon: Icon(icon, color: iconColor)),
          ),
        )));
  }
}
