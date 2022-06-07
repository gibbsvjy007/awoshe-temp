// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map json) {
  return Chat(
    id: json['id'] as String,
    chatId: json['chatId'] as String,
    createdOn: Utils.getDateTimeFromEpochUs(json['createdOn'] as int),
    sender:
        json['sender'] == null ? null : User.fromJson(json['sender'] as Map),
    receiver: json['receiver'] == null
        ? null
        : User.fromJson(json['receiver'] as Map),
    messageType: Utils.getMessageType(json['messageType'] as int),
    message: json['message'] as String,
    updatedOn: Utils.getDateTimeFromEpochUs(json['updatedOn'] as int),
    unReadCount: json['unReadCount'] as int ?? 0,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'unReadCount': instance.unReadCount,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'message': instance.message,
      'createdOn': instance.createdOn?.toIso8601String(),
      'updatedOn': instance.updatedOn?.toIso8601String(),
      'messageType': Utils.setMessageType(instance.messageType),
    };
