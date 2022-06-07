import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../constants.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  Message(
      {
        this.id,
        this.chatId,
        this.createdOn,
        this.sender,
        this.receiver,
        this.messageType,
        this.message,
        this.updatedOn,
        this.unReadCount,
        this.payload
});

  final String id;
  final String chatId;

  @JsonKey(defaultValue: 0)
  final int unReadCount;

  final User receiver;
  final User sender;

  @JsonKey(defaultValue: '')
  final String message;

  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  final DateTime createdOn;

  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  final DateTime updatedOn;

  @JsonKey(fromJson: Utils.getMessageType, toJson: Utils.setMessageType)
  final MessageType messageType;

  @JsonKey(includeIfNull: false)
  final Map<String, dynamic> payload;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
