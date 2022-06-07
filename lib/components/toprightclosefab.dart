import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AwosheTopRightCloseFab extends StatelessWidget {

  AwosheTopRightCloseFab({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top:50.0,right:15.0),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 0.0, horizontal: 0.0),
            child: Container(
                width: 30.0,
                height: 30.0,
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
      ),
    );
  }
}
