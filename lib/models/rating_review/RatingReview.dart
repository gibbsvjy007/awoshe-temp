import 'package:json_annotation/json_annotation.dart';

part 'RatingReview.g.dart';

@JsonSerializable()
class RatingReview {

  @JsonKey(includeIfNull: false)
  String id;

  String ratingDesc;
  double experienceRating,
      designerRating, productRating;

  RatingReview({this.ratingDesc, this.experienceRating,
    this.designerRating, this.productRating});

  factory RatingReview.fromJson(Map<String, dynamic> json) =>
      _$RatingReviewFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RatingReviewToJson(this);
}