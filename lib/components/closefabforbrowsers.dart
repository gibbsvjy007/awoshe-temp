import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';


class AwosheCloseFabForBrowser extends StatelessWidget {
  AwosheCloseFabForBrowser({@required this.onPressed, this.diameter});

  final GestureTapCallback onPressed;
  final diameter;

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 15.0),
          child: Container(
              width: diameter ?? 30.0,
              height: diameter ?? 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                //border: Border.all(width: 0.0, color: secondaryColor),
                color: awYellowColor,
              ),
              child: IconButton(
                  padding: EdgeInsets.all(0.0),
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.close,
                    color: secondaryColor,
                    size: 20.0,
                  ),
                  color: awBlack,
                  onPressed: (){
                    Navigator.pop(context);
                  },)),
        ),
      ),
    );
  }
}
