// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favourite _$FavouriteFromJson(Map json) {
  return Favourite(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    price: Utils.getPrice(json['price']),
    currency: json['currency'] as String,
    creator:
        json['creator'] == null ? null : User.fromJson(json['creator'] as Map),
    favouritedOn: json['favouritedOn'] as int,
    itemId: json['itemId'] as String,
  );
}

Map<String, dynamic> _$FavouriteToJson(Favourite instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'currency': instance.currency,
      'creator': instance.creator,
      'favouritedOn': instance.favouritedOn,
      'itemId': instance.itemId,
    };
