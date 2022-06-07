//import 'package:Awoshe/models/messages/message.dart';
//import 'package:Awoshe/pages/message/chat_detail/received_message.dart';
//import 'package:Awoshe/pages/message/chat_detail/sent_message.dart';
//import 'package:flutter/material.dart';
//
//class ChatMessageListItem extends StatelessWidget {
//  final Message message;
//  final String currentUserId;
//
//  ChatMessageListItem({this.message, this.currentUserId});
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      margin: const EdgeInsets.symmetric(vertical: 10.0),
//      child: currentUserId == message.sender.id
//          ? SentMessage(message: message,)
//          : ReceivedMessage(message: message,),
//    );
//  }
//}
