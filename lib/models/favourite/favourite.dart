import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite.g.dart';

@JsonSerializable()
class Favourite {
  String id;
  String title;
  String description;
  String imageUrl;

  @JsonKey(fromJson: Utils.getPrice)
  String price;
  String currency;
  User creator;
  int favouritedOn;
  String itemId;

  Favourite(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.currency,
      this.creator,
      this.favouritedOn,
      this.itemId});

  factory Favourite.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteToJson(this);
}
