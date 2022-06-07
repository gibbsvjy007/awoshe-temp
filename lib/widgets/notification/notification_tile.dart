import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  NotificationTile(
      {this.leading,
      this.trailing,
      this.title,
      this.subTitle,
      this.contentPadding,
      this.enabled = true,
      this.spaceBetween = 20.0,
      this.backgroundColor = Colors.transparent,
      this.onTap});

  final Widget leading, title, trailing, subTitle;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final Color backgroundColor;
  final GestureTapCallback onTap;
  final double spaceBetween;

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);

    return Material(
      color: backgroundColor,
      child: SafeArea(
        top: false,
        bottom: false,
        child: _ListTile(
          leading: leading,
          title: title,
          subTitle: subTitle,
          trailing: trailing,
          textDirection: textDirection,
          onTap: onTap,
          backgroundColor: backgroundColor,
          contentPadding: contentPadding,
          spaceBetween: spaceBetween,
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  _ListTile(
      {this.leading,
      this.trailing,
      this.title,
      this.subTitle,
      this.contentPadding,
      this.enabled = true,
      this.onTap,
      this.backgroundColor,
      this.textDirection,
      this.spaceBetween});

  final Widget leading, title, trailing, subTitle;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final Color backgroundColor;
  final GestureTapCallback onTap;
  final TextDirection textDirection;
  final double spaceBetween;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: contentPadding ??
            EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: awLightColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            leading ?? Container(),
            Padding(
                padding: EdgeInsets.only(
                    left: spaceBetween != null
                        ? ((leading != null) ? spaceBetween : 0.0)
                        : 0.0)),
            title != null
                ? Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      title,
                      if (subTitle != null)
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: subTitle,
                        )
                    ],
                  ))
                : Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  margin: EdgeInsets.only(top: 5.0, left: 10.0),
                  child: trailing,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
