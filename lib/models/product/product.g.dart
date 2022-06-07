// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map json) {
  return Product(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    productCare: json['productCare'] as String,
    productType: getProductType(json['productType'] as int),
    price: Utils.getPrice(json['price']),
    distanceUnit: json['distanceUnit'] as String,
    careInfo: getCareTypeValues(json['careInfo'] as List),
    owner: json['owner'] as String,
    currency: json['currency'] as String,
    imageUrl: json['imageUrl'] as String,
    itemId: json['itemId'] as String,
    occassions: (json['occassions'] as List)?.map((e) => e as String)?.toList(),
    orderType: json['orderType'] as String ?? 'STANDARD',
    availableColors:
        (json['availableColors'] as List)?.map((e) => e as String)?.toList(),
    sizes: (json['sizes'] as List)?.map((e) => e as String)?.toList(),
    fabricTags: (json['fabricTags'] as List)?.map((e) => e as String)?.toList(),
    images: (json['images'] as List)?.map((e) => e as String)?.toList() ?? [],
    currentSizeIndex: json['currentSizeIndex'] as int,
    otherInfos: json['otherInfos'] as String,
    customMeasurements:
        (json['customMeasurements'] as List)?.map((e) => e as String)?.toList(),
    mainCategory: json['mainCategory'] as String,
    collection: json['collection'] == null
        ? null
        : Collection.fromJson((json['collection'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    subCategory: json['subCategory'] as String,
    orientation: json['orientation'] as String,
    feedType: getFeedType(json['feedType'] as int),
    creator: json['creator'] == null
        ? null
        : Creator.fromJson(json['creator'] as Map),
    isFavourited: json['isFavourited'] as bool ?? false,
    totalReviews: json['totalReviews'] as int ?? 0,
    status: json['status'] as String,
    isAvailable: json['isAvailable'] as bool ?? true,
    videoUrl: json['videoUrl'] as String,
    customColors: (json['customColors'] as Map)?.map(
          (k, e) => MapEntry(k as String, e),
        ) ??
        {},
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('itemId', instance.itemId);
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['price'] = instance.price;
  writeNotNull('owner', instance.owner);
  writeNotNull('status', instance.status);
  writeNotNull('imageUrl', instance.imageUrl);
  val['productCare'] = instance.productCare;
  writeNotNull('images', instance.images);
  val['productType'] = getProductTypeIndex(instance.productType);
  val['occassions'] = instance.occassions;
  writeNotNull('orderType', instance.orderType);
  writeNotNull('availableColors', instance.availableColors);
  writeNotNull('fabricTags', instance.fabricTags);
  writeNotNull('sizes', instance.sizes);
  writeNotNull('customMeasurements', instance.customMeasurements);
  val['otherInfos'] = instance.otherInfos;
  val['currency'] = instance.currency;
  val['currentSizeIndex'] = instance.currentSizeIndex;
  writeNotNull('mainCategory', instance.mainCategory);
  writeNotNull('subCategory', instance.subCategory);
  val['collection'] = instance.collection;
  val['feedType'] = getFeedTypeIndex(instance.feedType);
  writeNotNull('orientation', instance.orientation);
  writeNotNull('creator', instance.creator);
  writeNotNull('distanceUnit', instance.distanceUnit);
  val['isAvailable'] = instance.isAvailable;
  writeNotNull('customColors', instance.customColors);
  writeNotNull('careInfo', getCareTypeIndexes(instance.careInfo));
  writeNotNull('isFavourited', instance.isFavourited);
  val['videoUrl'] = instance.videoUrl;
  val['totalReviews'] = instance.totalReviews;
  return val;
}
