import 'package:Awoshe/components/message/user_avatar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/messages/chat.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:Awoshe/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  ChatItem({this.chat, this.currentUserId, this.onTap});

  final Chat chat;
  final String currentUserId;
  final VoidCallback onTap;

//  final String imageUrl;
//  final String title;
//  final String subtitle;
//  final Widget trailing;
//  final VoidCallback onTap;
//  final MessageType type;
//  final bool isUnread;

  @override
  ChatItemState createState() {
    return ChatItemState();
  }
}

class ChatItemState extends State<ChatItem> {

  @override
  Widget build(BuildContext context) {
    DateTime messageTime = widget.chat.createdOn;
    var receiverId = widget.chat.receiver.id;

    var user = (receiverId == widget.currentUserId) ? widget.chat.sender : widget.chat.receiver;

    return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        onTap: widget.onTap,

        dense: true,

        leading: UserAvatar(
          avatarUrl: user.thumbnailUrl,
          userId: user.id,
          fullName: user.name,
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ],
        ),

        subtitle: Container(
          padding: const EdgeInsets.only(top: 2.0),
          child: _getSubtitleWidget(),),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Utils.getMessageTime(messageTime),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: awLightColor, fontSize: 10.0),
            ),
            SizedBox(height: 5.0),
            widget.chat.unReadCount > 0
                ? CircleAvatar(
                    radius: 10.0,
                    backgroundColor: primaryColor,
                    child: Text(
                      widget.chat.unReadCount.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.0,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }

  Widget _getSubtitleWidget() {
    
    switch(widget.chat.messageType){

      case MessageType.TEXT:
        return Text(
          widget.chat.message,
          style: TextStyle(
              color: widget.chat != null && widget.chat.unReadCount > 0 ? primaryColor: awLightColor,
              fontSize: 13.0,
              fontWeight: FontWeight.w600),
        );
        break;
        
      case MessageType.IMAGE:
      case MessageType.EMOJI:
        return getImageText();
        break;

      case MessageType.APPROVED:
      case MessageType.OFFER:
        return getOfferWidget();
        break;
      case MessageType.REVIEW:
        return buildReviewSubtitle();
        break;
    }

  }

  Widget buildReviewSubtitle() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.star,
        color: awLightColor,
        size: 15.0,
      ),
      SizedBox(width: 10.0),
      Flexible(
        child: Text(widget.chat.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: awLightColor, fontSize: 12.0)),
      )
    ],
  );

  Widget getImageText() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(
        Icons.camera_alt,
        color: awLightColor,
        size: 15.0,
      ),
      SizedBox(width: 10.0),
      Text("Photo", style: TextStyle(color: awLightColor, fontSize: 12.0))
    ],
  );


  Widget getOfferWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgIcon(
          Assets.offer,
          color: awLightColor,
          size: 15.0,
        ),
        SizedBox(width: 10.0),

        Flexible(
          child: Text("${widget.chat.message}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: awLightColor, fontSize: 12.0)),
        )
      ],
    );
  }
}