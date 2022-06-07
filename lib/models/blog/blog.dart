import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable()
class Blog {
  @JsonKey(includeIfNull: false)
  String id;
  String title;
  String description;
  String url;

  String imageUrl;

  String mainCategory;

  @JsonKey(defaultValue: [])
  List<String> images;

  String status;
  @JsonKey(includeIfNull: false)
  User creator;
  @JsonKey(includeIfNull: false)
  int createdOn;
  @JsonKey(fromJson: getFeedType)
  FeedType feedType;

  Blog({this.id,
    this.title,
    this.description,
    this.url,
    this.feedType,
    this.imageUrl,
    this.images,
    this.mainCategory,
    this.status,
    this.creator,
  });

  factory Blog.fromJson(Map<String, dynamic> json) =>
      _$BlogFromJson(json);

  Map<String,dynamic> toJson() =>
      _$BlogToJson(this);
}

FeedType getFeedType(int type) => Utils.getFeedType(type);
