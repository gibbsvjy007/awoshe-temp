// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map json) {
  return Feed(
    title: json['title'] as String,
    id: json['id'] as String,
    description: json['description'] as String,
    mainCategory: json['mainCategory'] as String,
    subCategory: json['subCategory'] as String,
    creator:
        json['creator'] == null ? null : User.fromJson(json['creator'] as Map),
    createdOn: Utils.getDateTimeFromEpochUs(json['createdOn'] as int),
    updatedOn: Utils.getDateTimeFromEpochUs(json['updatedOn'] as int),
    type: getFeedType(json['type'] as int),
    collection: json['collection'] == null
        ? null
        : Collection.fromJson((json['collection'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    products: json['products'] as List ?? [],
    isFavourited: json['isFavourited'] as bool ?? false,
    imageUrl: json['imageUrl'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$FeedToJson(Feed instance) {
  final val = <String, dynamic>{
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['description'] = instance.description;
  val['mainCategory'] = instance.mainCategory;
  val['subCategory'] = instance.subCategory;
  val['creator'] = instance.creator;
  val['createdOn'] = instance.createdOn?.toIso8601String();
  val['updatedOn'] = instance.updatedOn?.toIso8601String();
  val['type'] = _$FeedTypeEnumMap[instance.type];
  val['collection'] = instance.collection;
  val['products'] = instance.products;
  val['isFavourited'] = instance.isFavourited;
  writeNotNull('imageUrl', instance.imageUrl);
  val['url'] = instance.url;
  return val;
}

const _$FeedTypeEnumMap = {
  FeedType.BLOG: 'BLOG',
  FeedType.TH: 'TH',
  FeedType.SW: 'SW',
  FeedType.SINGLE: 'SINGLE',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Feed on _Feed, Store {
  final _$titleAtom = Atom(name: '_Feed.title');

  @override
  String get title {
    _$titleAtom.context.enforceReadPolicy(_$titleAtom);
    _$titleAtom.reportObserved();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.context.conditionallyRunInAction(() {
      super.title = value;
      _$titleAtom.reportChanged();
    }, _$titleAtom, name: '${_$titleAtom.name}_set');
  }

  final _$descriptionAtom = Atom(name: '_Feed.description');

  @override
  String get description {
    _$descriptionAtom.context.enforceReadPolicy(_$descriptionAtom);
    _$descriptionAtom.reportObserved();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.context.conditionallyRunInAction(() {
      super.description = value;
      _$descriptionAtom.reportChanged();
    }, _$descriptionAtom, name: '${_$descriptionAtom.name}_set');
  }

  final _$productsAtom = Atom(name: '_Feed.products');

  @override
  List<dynamic> get products {
    _$productsAtom.context.enforceReadPolicy(_$productsAtom);
    _$productsAtom.reportObserved();
    return super.products;
  }

  @override
  set products(List<dynamic> value) {
    _$productsAtom.context.conditionallyRunInAction(() {
      super.products = value;
      _$productsAtom.reportChanged();
    }, _$productsAtom, name: '${_$productsAtom.name}_set');
  }

  final _$isFavouritedAtom = Atom(name: '_Feed.isFavourited');

  @override
  bool get isFavourited {
    _$isFavouritedAtom.context.enforceReadPolicy(_$isFavouritedAtom);
    _$isFavouritedAtom.reportObserved();
    return super.isFavourited;
  }

  @override
  set isFavourited(bool value) {
    _$isFavouritedAtom.context.conditionallyRunInAction(() {
      super.isFavourited = value;
      _$isFavouritedAtom.reportChanged();
    }, _$isFavouritedAtom, name: '${_$isFavouritedAtom.name}_set');
  }
}
