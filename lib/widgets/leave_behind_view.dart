import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';

class LeaveBehindView extends StatelessWidget {
  LeaveBehindView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
      child: Row (
        children: <Widget>[
          Icon(Icons.delete, color: Colors.white,),
          Expanded(
            child: Text('Delete', style: TextStyle(color: Colors.white),),
          ),
          Icon(Icons.delete, color: Colors.white,),
          Text('Delete', style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }

}