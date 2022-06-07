import 'package:Awoshe/constants.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class InputField extends StatelessWidget {
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
  final double radius;
  final bool isBorder;
  final double verticalPadding;
  final double leftPadding;
  final TextInputAction textInputAction;

  //passing props in the Constructor.
  //Java like style
  InputField(
      {this.key,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.textFieldColor,
      this.icon,
      this.iconColor,
      this.bottomMargin,
      this.textStyle,
      this.textInputAction,
      this.textAlign,
      this.leftPadding,
      this.validateFunction,
      this.borderColor,
      this.onSaved,
      this.floatingLabel,
      this.controller,
      this.hintStyle,
      this.radius,
      this.isBorder,
      this.verticalPadding,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: TextFormField(
          validator: validateFunction,
          style: textStyle,
          key: key,
          obscureText: obscureText,
          keyboardType: textInputType,
          maxLines: maxLines,
          controller: controller,
          textAlign: textAlign != null ? this.textAlign : TextAlign.left,
          onSaved: onSaved,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              errorStyle: TextStyle(color: Colors.redAccent),
              contentPadding: floatingLabel != null
                  ? EdgeInsets.only(
                      top: verticalPadding ?? 13.0,
                      bottom: verticalPadding ?? 13.0,
                      left: leftPadding ?? 0.0)
                  : EdgeInsets.only(
                      bottom: verticalPadding ?? 13.0,
                      top: verticalPadding ?? 13.0,
                      left: leftPadding ?? 0.0),
              fillColor: Colors.white70,
              filled: true,
              labelText: floatingLabel,
              border: isBorder != null && isBorder ? OutlineInputBorder(
                  borderSide: BorderSide(color: awLightColor),
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? APP_INPUT_RADIUS))
              ) : InputBorder.none,
              ),
        )));
  }
}

class InputFieldV2 extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final Color textFieldColor, iconColor;
  final bool obscureText;
  final double bottomMargin;
  final TextStyle textStyle, hintStyle;
  final Function onChanged;
  final Color borderColor;
  final TextEditingController controller;
  final String floatingLabel;
  final Key key;
  final TextAlign textAlign;
  final int maxLines;
  final String errorText;
  final double leftPadding;
  final double radius;
  final int hintMaxLines;
  final Color fillColor;
  final double verticalPadding;
  final dynamic suffixIcon;
  final bool autofocus;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final InputDecoration decoration;
  final TextInputAction textInputAction;
  //passing props in the Constructor.
  //Java like style
  InputFieldV2(
      {this.key,
      this.hintText,
      this.obscureText,
      this.textInputType,
      this.textFieldColor,
      this.textInputAction,
      this.icon,
      this.iconColor,
      this.bottomMargin,
      this.textStyle,
      this.textAlign,
      this.borderColor,
      this.onChanged,
      this.floatingLabel,
      this.autofocus,
      this.controller,
      this.hintStyle,
      this.maxLines = 1,
      this.radius,
      this.fillColor,
      this.hintMaxLines,
      this.verticalPadding,
      this.leftPadding,
      this.suffixIcon,
      this.errorText,
      this.focusNode,
      this.onTap,
      this.decoration,

      });

  @override
  Widget build(BuildContext context) {
    return (Container(
      margin: EdgeInsets.only(bottom: bottomMargin ?? 0.0),
      child: TextField(
        style: textStyle,
        key: key,
        onTap: onTap,

        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: textInputType,
        autofocus: autofocus ?? false,
        maxLines: maxLines,
        controller: controller,
        textAlign: textAlign != null ? this.textAlign : TextAlign.left,
        onChanged: onChanged,
        textInputAction: textInputAction,
        decoration: decoration ?? InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: hintStyle,
          //hintMaxLines: hintMaxLines ?? 1,
          errorStyle: TextStyle(color: Colors.redAccent),
          contentPadding: floatingLabel != null
              ? EdgeInsets.only(
                  top: verticalPadding ?? 13.0,
                  bottom: verticalPadding ?? 13.0,
                  left: leftPadding ?? 0.0)
              : EdgeInsets.only(
                  bottom: verticalPadding ?? 13.0,
                  top: verticalPadding ?? 13.0,
                  left: leftPadding ?? 0.0),
          fillColor: fillColor ?? Colors.white,
          filled: true,
          labelText: floatingLabel,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 50.0),
            ),
          ),
        ),
      ),
    ));
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
            maxLines: 1,
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
