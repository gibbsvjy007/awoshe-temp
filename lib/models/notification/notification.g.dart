// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map json) {
  return Notifications(
    id: json['id'] as String,
    createdOn: _dateTimeFromEpochUs(json['createdOn'] as int),
    payload: (json['payload'] as Map)?.map(
      (k, e) => MapEntry(k as String, e),
    ),
    type: _getNotificationType(json['type'] as String),
    proccessedOn: _dateTimeFromEpochUs(json['proccessedOn'] as int),
    content: (json['content'] as Map)?.map(
      (k, e) => MapEntry(k as String, e),
    ),
  );
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) {
  final val = <String, dynamic>{
    'type': _$NotificationTypeEnumMap[instance.type],
    'id': instance.id,
    'createdOn': instance.createdOn?.toIso8601String(),
    'payload': instance.payload,
    'content': instance.content,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('proccessedOn', instance.proccessedOn?.toIso8601String());
  return val;
}

const _$NotificationTypeEnumMap = {
  NotificationType.USER_FOLLOW: 'USER_FOLLOW',
  NotificationType.USER_UNFOLLOW: 'USER_UNFOLLOW',
  NotificationType.USER_REGISTER: 'USER_REGISTER',
  NotificationType.USER_UPDATED: 'USER_UPDATED',
  NotificationType.ORDER_CREATED: 'ORDER_CREATED',
};
