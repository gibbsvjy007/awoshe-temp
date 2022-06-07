import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AwosheLeftCloseFab extends StatelessWidget {

  AwosheLeftCloseFab({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left:25.0,bottom:20.0),
        child: Align(
          alignment: Alignment.bottomLeft,

          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 15.0),
            child: Container(
//                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0),
                  //border: Border.all(width: 0.0, color: secondaryColor),
                  color: awYellowColor,
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  padding: EdgeInsets.all(0.0),
                  textColor: secondaryColor,
                  child: Text("DONE", style: TextStyle(fontWeight: FontWeight.w600),),



//                  icon: Icon(
//                    Icons.close,
//                    color: secondaryColor,
//                    size: 20.0,
//                  ),
                  color: awYellowColor,
                  onPressed: (){
                    if (onPressed != null)
                      onPressed();
                    //Navigator.pop(context);
                  },)),
          ),
        ),
      ),
    );
  }
}
