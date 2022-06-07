import 'package:equatable/equatable.dart';

class MessageEvent extends Equatable {
  MessageEvent({
    this.event,
    this.content,
    this.senderId,
    this.receiverId,
    this.type,
    this.timestamp,
    this.receiverImage,
    this.receiverName
  });

  final MessageEventType event;
  final String content;
  final String senderId;
  final String receiverId;
  final int type;
  final String timestamp;
  final String receiverImage;
  final String receiverName;
}

enum MessageEventType {
  none,
  send_message,
}