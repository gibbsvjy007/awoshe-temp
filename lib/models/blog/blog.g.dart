// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blog _$BlogFromJson(Map json) {
  return Blog(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    feedType: getFeedType(json['feedType'] as int),
    imageUrl: json['imageUrl'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList() ?? [],
    mainCategory: json['mainCategory'] as String,
    status: json['status'] as String,
    creator:
        json['creator'] == null ? null : User.fromJson(json['creator'] as Map),
  )..createdOn = json['createdOn'] as int;
}

Map<String, dynamic> _$BlogToJson(Blog instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['url'] = instance.url;
  val['imageUrl'] = instance.imageUrl;
  val['mainCategory'] = instance.mainCategory;
  val['images'] = instance.images;
  val['status'] = instance.status;
  writeNotNull('creator', instance.creator);
  writeNotNull('createdOn', instance.createdOn);
  val['feedType'] = _$FeedTypeEnumMap[instance.feedType];
  return val;
}

const _$FeedTypeEnumMap = {
  FeedType.BLOG: 'BLOG',
  FeedType.TH: 'TH',
  FeedType.SW: 'SW',
  FeedType.SINGLE: 'SINGLE',
};
