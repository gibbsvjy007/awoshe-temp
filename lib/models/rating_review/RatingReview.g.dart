// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RatingReview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingReview _$RatingReviewFromJson(Map json) {
  return RatingReview(
    ratingDesc: json['ratingDesc'] as String,
    experienceRating: (json['experienceRating'] as num)?.toDouble(),
    designerRating: (json['designerRating'] as num)?.toDouble(),
    productRating: (json['productRating'] as num)?.toDouble(),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$RatingReviewToJson(RatingReview instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['ratingDesc'] = instance.ratingDesc;
  val['experienceRating'] = instance.experienceRating;
  val['designerRating'] = instance.designerRating;
  val['productRating'] = instance.productRating;
  return val;
}
