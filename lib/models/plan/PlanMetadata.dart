import 'package:json_annotation/json_annotation.dart';

part 'PlanMetadata.g.dart';

@JsonSerializable()
class PlanMetadata {

  String include;

  String description;

  PlanMetadata();

  factory PlanMetadata.fromJson( Map<String,dynamic> json ) => _$PlanMetadataFromJson(json);

  Map<String,dynamic> toJson()  => _$PlanMetadataToJson(this);
}