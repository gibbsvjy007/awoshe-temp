import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  Chat(
      {this.id,
      this.chatId,
      this.createdOn,
      this.sender,
      this.receiver,
      this.messageType,
      this.message,
      this.updatedOn,
      this.unReadCount});

  final String id;
  final String chatId;

  @JsonKey(defaultValue: 0)
  final int unReadCount;

  final User receiver;
  final User sender;

  final String message;

  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  final DateTime createdOn;

  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  final DateTime updatedOn;

  @JsonKey(fromJson: Utils.getMessageType, toJson: Utils.setMessageType)
  final MessageType messageType;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

