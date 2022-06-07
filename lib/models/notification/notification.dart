import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'notification_types.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notifications {
  @JsonKey(fromJson: _getNotificationType)
  final NotificationType type;
  final String id;
  @JsonKey(fromJson: _dateTimeFromEpochUs)
  final DateTime createdOn;
  final Map<String, dynamic> payload;
  final Map<String, dynamic> content;

  @JsonKey(fromJson: _dateTimeFromEpochUs, includeIfNull: false)
  final DateTime proccessedOn;

  Notifications(
      {@required this.id,
      this.createdOn,
      this.payload,
      this.type,
      this.proccessedOn,
      this.content});

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}

NotificationType _getNotificationType(String type) =>
    NotificationTypes.getNotificationType(type);

DateTime _dateTimeFromEpochUs(int us) =>
    DateTime.fromMillisecondsSinceEpoch(us ?? 0);
