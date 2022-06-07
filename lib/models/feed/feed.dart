import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/collection/collection.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'feed.g.dart';

@JsonSerializable()
class Feed extends _Feed with _$Feed {
  static final empty = Feed(
    mainCategory: '',

  );

  Feed({
    String title,
    String id,
    String description,
    String mainCategory,
    String subCategory,
    User creator,
    DateTime createdOn,
    DateTime updatedOn,
    FeedType type,
    Collection collection,
    List<dynamic> products = const [],
    bool isFavourited = false,
    String imageUrl,
    String url
  }) : super(
      id: id,
      creator: creator,
      title: title,
      description: description,
      createdOn: createdOn,
      updatedOn: updatedOn,
      type: type,
      mainCategory: mainCategory,
      subCategory: subCategory,
      imageUrl: imageUrl,
      collection: collection,
      products: products,
      isFavourited: isFavourited,
      url: url
  );

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

  Map<String, dynamic> toJson() => _$FeedToJson(this);
}

abstract class _Feed with Store {
  _Feed({
    String title,
    String id,
    String description,
    String mainCategory,
    String subCategory,
    User creator,
    DateTime createdOn,
    DateTime updatedOn,
    FeedType type,
    Collection collection,
    List<dynamic> products,
    bool isFavourited,
    String imageUrl,
    String url
  }) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.createdOn = createdOn;
    this.updatedOn = updatedOn;
    this.creator = creator;
    this.type = type;
    this.mainCategory = mainCategory;
    this.subCategory = subCategory;
    this.imageUrl = imageUrl;
    this.collection = collection;
    this.products = products;
    this.isFavourited = isFavourited;
    this.url = url;
  }

  @observable
  String title;
  @JsonKey(includeIfNull: false)
  String id;
  @observable
  String description;
  String mainCategory;
  String subCategory;
  User creator;
  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  DateTime createdOn;
  @JsonKey(fromJson: Utils.getDateTimeFromEpochUs)
  DateTime updatedOn;

  @JsonKey(fromJson: getFeedType)
  FeedType type;
  Collection collection;
  @observable
  @JsonKey(defaultValue: [])
  List<dynamic> products;
  @observable
  @JsonKey(defaultValue: false)
  bool isFavourited;

  @JsonKey(includeIfNull: false)
  String imageUrl;
  String url;
}

FeedType getFeedType(int type) => Utils.getFeedType(type);
