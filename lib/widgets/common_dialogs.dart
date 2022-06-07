import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
showSuccess(BuildContext context, String message, IconData icon) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ));
}

showAlert(BuildContext context, title, message) {
  showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("CLOSE"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("OK"),
                textColor: primaryColor,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
}

showProgress(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
            child: CircularProgressIndicator(
              backgroundColor: primaryColor,
            ),
          ));
}

hideProgress(BuildContext context) {
  Navigator.pop(context);
}
