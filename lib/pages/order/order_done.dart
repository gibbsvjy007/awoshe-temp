import 'package:Awoshe/router.dart';
import 'package:Awoshe/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'dart:async';

class OrderDone extends StatefulWidget {
  @override
  _OrderDoneState createState() => new _OrderDoneState();
}

class _OrderDoneState extends State<OrderDone> {
  bool _animate = true;

  @override
  void initState() {
    super.initState();
    stopAnimation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  stopAnimation() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        this._animate = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Thank you!",
            style: textStyleLargeBlack,
          ),
          VerticalSpace(20.0),
          _animate
              ? CircularProgressIndicator(
                  backgroundColor: secondaryColor,
                )
              : Icon(
                  Icons.check_circle,
                  size: 100.0,
                  color: secondaryColor,
                ),
          VerticalSpace(20.0),
          Text(
            "We will contact you as",
            style: textStyle14sec,
          ),
          Text(
            "soon as possible",
            style: textStyle14sec,
          ),
          VerticalSpace(100.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: RoundedButton(
                buttonName: "Back to Home",
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
                },
                width: deviceSize.width,
                height: 50.0,
                buttonColor: primaryColor),
          )
        ],
      ),
    ));
  }
}
