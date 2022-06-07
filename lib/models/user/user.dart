import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String id;
  final String thumbnailUrl;
  final String handle;
  final bool online;

  const User(
      {@required this.id,
        @required this.name,
        this.online = false,
        this.thumbnailUrl = '',
        this.handle = ''});

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
