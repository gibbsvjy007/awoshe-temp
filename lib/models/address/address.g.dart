// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map json) {
  return Address(
    fullName: json['fullName'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    zipCode: json['zipCode'] as String,
    country: json['country'] as String,
    type: json['type'] as int,
    isDefault: json['isDefault'] as bool,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'type': instance.type,
      'isDefault': instance.isDefault,
    };
