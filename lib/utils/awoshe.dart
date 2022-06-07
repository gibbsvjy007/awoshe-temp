import 'package:Awoshe/constants.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class Awoshe {
  static Awoshe _instance;
  factory Awoshe() => _instance ??= Awoshe._();
  Awoshe._();

  static alertDialog(BuildContext context, String title, String message,
      {callback}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                if (callback != null) callback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showSimpleDialog(BuildContext context,
      {String title, Function onTap, String content}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(10.0),
            //backgroundColor: Colors.white,
            title: title != null
                ? Text(
                    title,
                    style: TextStyle(fontSize: 16.0),
                  )
                : Container(),
            children: <Widget>[
              Container(
                child: Text(
                  content,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text("OK", style: TextStyle(color: primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onTap != null) onTap();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  static showImagePickerSelectOptions(BuildContext context, Function onTap) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(15.0),
            //backgroundColor: Colors.white,
            title: Text(
              "Choose....",
              style: TextStyle(fontSize: 16.0),
            ),
            children: <Widget>[
              ListTile(
                dense: true,
                leading: Icon(Icons.photo_album),
                title: Text(
                  "Gallery",
                  style: TextStyle(fontSize: 14.0),
                ),
                onTap: () {
                  onTap(PhotoSourceType.GALLERY);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.camera_alt),
                title: Text(
                  "Camera",
                  style: TextStyle(fontSize: 14.0),
                ),
                onTap: () {
                  onTap(PhotoSourceType.CAMERA);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static showToast(message, BuildContext context) {
    Flushbar(
        message: message.toString(),
        flushbarStyle: FlushbarStyle.FLOATING,
        leftBarIndicatorColor: primaryColor,
        isDismissible: true,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: primaryColor,
        ),
        duration: Duration(seconds: 2))
      ..show(context);
  }
}
