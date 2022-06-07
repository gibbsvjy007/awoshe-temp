// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) {
  return Message(
    id: json['id'] as String,
    chatId: json['chatId'] as String,
    createdOn: Utils.getDateTimeFromEpochUs(json['createdOn'] as int),
    sender:
        json['sender'] == null ? null : User.fromJson(json['sender'] as Map),
    receiver: json['receiver'] == null
        ? null
        : User.fromJson(json['receiver'] as Map),
    messageType: Utils.getMessageType(json['messageType'] as int),
    message: json['message'] as String ?? '',
    updatedOn: Utils.getDateTimeFromEpochUs(json['updatedOn'] as int),
    unReadCount: json['unReadCount'] as int ?? 0,
    payload: (json['payload'] as Map)?.map(
      (k, e) => MapEntry(k as String, e),
    ),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{
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

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('payload', instance.payload);
  return val;
}
