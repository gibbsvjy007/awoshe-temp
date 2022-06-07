import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function();

class NewFeedAvailableWidget extends StatelessWidget {
  final String title;
  final OnTap onTap;

  const NewFeedAvailableWidget({Key key, @required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        backgroundColor: secondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        elevation: 5.0,
        label: Text(title, style: TextStyle(color: Colors.white),),
        avatar: Icon(Icons.new_releases, color: Colors.white,),
      ),
    );
  }
}
