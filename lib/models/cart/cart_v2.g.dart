// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartV2 _$CartV2FromJson(Map json) {
  return CartV2(
    id: json['id'] as String,
    createdOn: json['createdOn'] as int,
    updatedOn: json['updatedOn'] as int,
    creator: json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map),
    items: (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : CartItemV2.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$CartV2ToJson(CartV2 instance) => <String, dynamic>{
      'id': instance.id,
      'createdOn': instance.createdOn,
      'updatedOn': instance.updatedOn,
      'creator': instance.creator?.toJson(),
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
