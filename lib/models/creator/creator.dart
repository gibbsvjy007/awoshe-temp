import 'package:json_annotation/json_annotation.dart';

part 'creator.g.dart';

@JsonSerializable()
class Creator {
  final String handle;
  final String id;
  final String name;
  final String thumbnailUrl;

  Creator({this.handle, this.id, this.name, this.thumbnailUrl});

  factory Creator.fromJson(Map json) =>
    _$CreatorFromJson(json);

  Map<String,dynamic> toJson() =>
      _$CreatorToJson(this);

}