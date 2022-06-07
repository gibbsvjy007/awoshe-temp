import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:Awoshe/theme/theme.dart';

enum ToastType { ERROR, SUCCESS, WARNING, INFO }

class ShowFlushToast {
  static Flushbar flush;
  VoidCallback callback;
  Duration duration;
  ShowFlushToast(BuildContext context, ToastType type, String message,
      {callback, this.duration,}) {
    Icon icon;
    Color bgColor;
    String title;
    switch (type) {
      case ToastType.ERROR:
        title = "Error";
        bgColor = Colors.redAccent;
        icon = Icon(
          Icons.error_outline,
          color: Colors.white,
        );
        break;

      case ToastType.SUCCESS:
        title = "Success";
        bgColor = Colors.lightGreen;
        icon = Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        );
        break;

      case ToastType.WARNING:
        title = "Warning";
        bgColor = Colors.orangeAccent;
        icon = Icon(
          Icons.warning,
          color: Colors.yellowAccent,
        );
        break;

      case ToastType.INFO:
        title = "Info";
        bgColor = primaryColor;
        icon = Icon(
          Icons.info_outline,
          color: Colors.white,
        );
        break;
    }

    flush = Flushbar<bool>(
        // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
        title: title,
        message: message,
        icon: icon,
        backgroundColor: bgColor,
        duration: duration ?? Duration(seconds: 5),
        mainButton: FlatButton(
          onPressed: () {
            flush.dismiss(true); // result = true
            if (callback != null) callback();
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        ));
    flush.show(context);
  }
}
