import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AwosheAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Function onConfirm;
  final Function onCancel;
  final bool hasActions;
  final bool hasWarning;
  final String cancelText;
  final String confirmText;
  const AwosheAlertDialog(
      {Key key,
        this.title,
        @required this.content,
        this.onConfirm,
        this.hasWarning = false,
        this.onCancel,
        this.cancelText = 'Cancel',
        this.confirmText = 'Yes',
        this.hasActions = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
        title: Container(
          alignment: Alignment.center,
          child: Center(child: title ?? Container()),
        ),
        titleTextStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            content,
            if (hasActions) SizedBox(height: 25.0),
            if (hasActions)
              Container(
                height: 45.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: hasWarning
                    ? Button(
                  child: Text(
                    'Ok',
                  ),
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),

                  // width: 120.0,
                  width: 130.0,
                  borderRadius: 23.0,
                  height: 55.0,
                  backgroundColor: primaryColor,
                  onPressed: onConfirm,
                )
                    : Row(
                  // mainAxisAlignment: main,
                  children: <Widget>[
                    Expanded(
                      child: Button(
                        child: Text(
                          cancelText.toUpperCase(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: Colors.transparent,
                        onPressed: onCancel,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    // Spacer(),
                    Expanded(
                      child: Button(
                        child: Text(confirmText.toUpperCase()),
                        textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                        borderRadius: 23.0,
//                        backgroundColor: primaryColor,
                        onPressed: onConfirm,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        // actions: actions,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0)),
      );

  }
}
