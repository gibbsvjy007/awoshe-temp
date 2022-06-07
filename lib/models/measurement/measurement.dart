import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

@JsonSerializable()
class Measurement {
  @JsonKey(defaultValue: 0.0)
  double height;

  @JsonKey(defaultValue: 0.0)
  double hip;

  @JsonKey(defaultValue: 0.0)
  double chest;

  @JsonKey(defaultValue: 0.0)
  double waist;

  @JsonKey(defaultValue: 0.0)
  double burst;

  @JsonKey(defaultValue: 0.0)
  double arms;

  Measurement(
      {this.height, this.hip, this.chest, this.waist, this.burst, this.arms});

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);
}
