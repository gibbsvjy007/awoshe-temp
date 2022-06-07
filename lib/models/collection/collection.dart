import 'package:Awoshe/constants.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {

  static final Collection DEFAULT_TYPE = Collection(title: 'SINGLE', id: 'SINGLE', displayType: FeedType.SINGLE);

  String description;
  String title;
  @JsonKey(
      toJson: getFeedTypeIndex,
      fromJson: getFeedType)
  FeedType displayType;
  String orientation;
  String id;
  int ratioX, ratioY;

  Collection({this.description, this.title, this.displayType, this.orientation,
      this.id, this.ratioX, this.ratioY});

  factory Collection.fromJson(Map<String, dynamic> json) =>
    _$CollectionFromJson(json);


  Map<String, dynamic> toJson() =>
      _$CollectionToJson(this);

}

int getFeedTypeIndex(FeedType type) => type.index;

FeedType getFeedType(int type) => Utils.getFeedType(type);
