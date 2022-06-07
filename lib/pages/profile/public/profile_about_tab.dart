import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileAboutTab extends StatelessWidget {
  final UserDetails userDetails;
  ProfileAboutTab({@required this.userDetails});

  Widget build(BuildContext context) {
    return Container(
//                decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Text(
                userDetails.name,
                style: textStyle1,
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListTile(
                subtitle: Text(
                  userDetails.description ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
