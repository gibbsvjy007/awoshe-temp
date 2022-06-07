import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

const _DEFAULT_BUTTON_RADIUS = 30.0;

class RoundedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;

  final double height;
  final double width;
  final double bottomMargin;
  final double borderWidth;
  final Color buttonColor;

  final TextStyle textStyle;

  //passing props in react style
  RoundedButton(
      {this.buttonName,
      this.onTap,
      this.height,
      this.bottomMargin,
      this.borderWidth,
      this.width,
      this.buttonColor,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    if (borderWidth != 0.0)
      return (new InkWell(
        onTap: onTap,
        child: new Container(
          width: width ?? 100.0,
          height: height ?? 50.0,
          margin: new EdgeInsets.only(bottom: bottomMargin ?? 2.0),
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
              color: buttonColor,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
              border: new Border.all(
                  color: const Color.fromRGBO(221, 221, 221, 1.0),
                  width: borderWidth ?? 0.0)),
          child: new Text(buttonName,
              style: textStyle != null ? textStyle : buttonTextStyle),
        ),
      ));
    else
      return (new InkWell(
        onTap: onTap,
        child: new Container(
          width: width ?? 100.0,
          height: height ?? 50.0,
          margin: new EdgeInsets.only(bottom: bottomMargin ?? 2.0),
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: buttonColor,
            borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
          ),
          child: new Text(buttonName,
              style: textStyle != null ? textStyle : buttonTextStyle),
        ),
      ));
  }
}

class AwosheButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;

  final double height;
  final double width;
  final double bottomMargin;
  final double borderWidth;
  final Color buttonColor;
  final double radius;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Widget childWidget;
  //passing props in react style
  AwosheButton(
      {this.buttonName,
      this.onTap,
      this.height,
      this.radius,
      this.bottomMargin,
      this.borderWidth,
      this.width,
      this.padding,
      this.childWidget,
      this.buttonColor,
      this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(radius ?? _DEFAULT_BUTTON_RADIUS)),
        splashColor: buttonColor,
        color: buttonColor,
        disabledColor: buttonColor,
        padding: padding ?? EdgeInsets.only(top: 10.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            childWidget,
          ],
        ),
        onPressed: onTap,
      ),
    );
  }
}

class AwosheRaisedButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;

  final double height;
  final double width;
  final double bottomMargin;
  final double borderWidth;
  final Color buttonColor;
  final double radius;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Widget childWidget;

  //passing props in react style
  AwosheRaisedButton(
      {this.buttonName,
      this.onTap,
      this.height,
      this.radius,
      this.bottomMargin,
      this.borderWidth,
      this.width,
      this.padding,
      this.childWidget,
      this.buttonColor,
      this.textStyle});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius ?? _DEFAULT_BUTTON_RADIUS)),
      splashColor: buttonColor,
      color: buttonColor,
      disabledColor: buttonColor,
      padding: padding ?? EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: childWidget,
          )
        ],
      ),
      onPressed: onTap,
    );
  }
}

typedef OnTap = void Function();
class CircularButton extends StatelessWidget {
  final Color color, borderColor;
  final double radius;
  final OnTap onTap;
  final Widget child;

  const CircularButton({Key key, this.radius = 30.0, this.borderColor, this.color = Colors.orange, this.onTap, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      clipBehavior: Clip.hardEdge,
      color: color,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(radius)),
      onPressed: onTap,
      child: Center(
        child: child,
      ),
    );
  }
}
