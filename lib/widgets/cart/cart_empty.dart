import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 00.0, bottom: 0.0),
                  height: 150.0,
                  width: 150.0,
                  child: Image.asset(Assets.emptyCart)),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  Localization.of(context).emptyCart,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
            ],
          )),
    );
  }
}
