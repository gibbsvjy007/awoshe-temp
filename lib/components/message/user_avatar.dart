import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  final String avatarUrl;
  final String userId;
  final String fullName;

  UserAvatar({Key key, @required this.avatarUrl, this.userId, @required this.fullName})
      : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    final hasProfileImage = widget.avatarUrl?.isNotEmpty ?? false;

    return Container(
        child: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          child: hasProfileImage
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                          padding: EdgeInsets.all(15.0),
                        ),
                    width: 50.0,
                    height: 50.0,
                    imageUrl: widget.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: hasProfileImage ? Colors.transparent : awBlack,
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(width: 2.0, color: Colors.white)),
                  child: Center(
                    child: Text(
                      Utils.getInitials(widget.fullName),
                      style: lightBoldText,
                    ),
                  ),
                ),
        ),
        Positioned(
          bottom: -5.0,
          left: 18.0,
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance.collection('profiles').document(widget.userId).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                DocumentSnapshot ds = snapshot.data;
                if (snapshot.hasData && ds.data != null) {
                  return Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ds['online'] != null && ds['online'] ? awGreen : awLightColor,
                        border: Border.all(color: Colors.white, width: 2.0, style: BorderStyle.solid)),
                  );
                }
                return Container();
              }),
        ),
      ],
    ));
  }
}
