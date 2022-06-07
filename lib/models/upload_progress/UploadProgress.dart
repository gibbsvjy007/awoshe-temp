import 'package:Awoshe/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UploadProgress.g.dart';

@JsonSerializable()
class UploadProgress {
  @JsonKey(toJson: _getEnumIndex, fromJson: _getEnumValue)
  final ProductType type;
  final String data;

  UploadProgress(this.type, this.data);

  Map<String, dynamic> toJson() => _$UploadProgressToJson(this);

  factory UploadProgress.fromJson(Map<String, dynamic> json) =>
      _$UploadProgressFromJson(json);

  static int _getEnumIndex(ProductType type) => type.index;

  static ProductType _getEnumValue(int index) => ProductType.values[index];
}
