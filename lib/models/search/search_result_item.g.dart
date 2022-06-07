// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultItem _$SearchResultItemFromJson(Map json) {
  return SearchResultItem(
    title: json['title'] as String,
    id: json['id'] as String,
    itemId: json['itemId'] as String,
    imageUrl: json['imageUrl'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    currency: json['currency'] as String,
  );
}

Map<String, dynamic> _$SearchResultItemToJson(SearchResultItem instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'id': instance.id,
    'imageUrl': instance.imageUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('itemId', instance.itemId);
  val['currency'] = instance.currency;
  val['price'] = instance.price;
  writeNotNull('description', instance.description);
  return val;
}
