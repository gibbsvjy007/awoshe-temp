import 'package:json_annotation/json_annotation.dart';

part 'search_result_item.g.dart';

@JsonSerializable()
class SearchResultItem {

  final String title;
  final String id;
  final String imageUrl;
  @JsonKey(includeIfNull: false)
  final String itemId;
  final String currency;
  final String price;
  @JsonKey(includeIfNull: false)
  final String description;

  SearchResultItem(
      {this.title, this.id, this.itemId, this.imageUrl, this.description, this.price, this.currency});

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultItemToJson(this);

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': this.id,
      'title': this.title,
      'itemId': this.itemId,
      'description': this.description,
      'imageUrl': this.imageUrl,
      'currency': this.currency,
      'price': this.price,
    };
  }

  factory SearchResultItem.fromDB(Map<String, dynamic> json) {
    return SearchResultItem(
      id: json['id'] as String,
      title: json['title'] as String,
      itemId: json['itemId'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      currency: json['currency'] as String,
      price: json['price'] as String,
    );
  }
}
