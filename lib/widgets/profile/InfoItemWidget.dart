import 'package:flutter/material.dart';

typedef OnTap = void Function();

class InfoItemWidget extends StatelessWidget {

  final String title;
  final String subtitle;
  final OnTap onTap;
  const InfoItemWidget({Key key, @required this.title, @required this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$title', style: TextStyle(fontSize: 21, color: Colors.black), textAlign: TextAlign.center,),
                  Text('$subtitle', style: TextStyle(fontSize: 13, color: Colors.grey), textAlign: TextAlign.center,),
                ],
              ),
            ),

            Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: onTap,
                  ),
                ),
            )
          ],
    );
  }
}
