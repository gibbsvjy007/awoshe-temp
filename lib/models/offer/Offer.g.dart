// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map json) {
  return Offer(
    id: json['id'] as String,
    deliveryDate: DateUtils.formatStringToDate(json['deliveryDate'] as String),
    measurement: json['measurement'] as bool,
    fabric: json['fabric'] as bool,
    productName: json['productName'] as String,
    productImageUrl: json['productImageUrl'] as String,
    comment: json['comment'] as String,
    price: json['price'] as String,
    approvedBy: json['approvedBy'] == null
        ? null
        : Creator.fromJson(json['approvedBy'] as Map),
    requestedBy: json['requestedBy'] == null
        ? null
        : Creator.fromJson(json['requestedBy'] as Map),
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['deliveryDate'] = DateUtils.formatDateToString(instance.deliveryDate);
  val['measurement'] = instance.measurement;
  val['fabric'] = instance.fabric;
  val['comment'] = instance.comment;
  writeNotNull('price', instance.price);
  writeNotNull('requestedBy', instance.requestedBy);
  writeNotNull('approvedBy', instance.approvedBy);
  writeNotNull('productName', instance.productName);
  writeNotNull('productImageUrl', instance.productImageUrl);
  return val;
}
