// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map json) {
  return UserDetails(
    id: json['uid'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    isAnonymous: json['isAnonymous'] as bool ?? false,
    thumbnailUrl: json['thumbnailUrl'] as String,
    handle: json['handle'] as String,
    pictureUrl: json['pictureUrl'] as String,
    coverUrl: json['coverUrl'] as String,
    description: json['description'] as String,
    location: json['location'] as String,
    followingCount: json['followingCount'] as int ?? 0,
    followersCount: json['followersCount'] as int ?? 0,
    designsCount: json['designsCount'] as int ?? 0,
    favouriteCount: json['favouriteCount'] as int ?? 0,
    cartCount: json['cartCount'] as int ?? 0,
    messageCount: json['messageCount'] as int ?? 0,
    follower: (json['follower'] as Map)?.map(
      (k, e) => MapEntry(k as String, e),
    ),
    isDesigner: _getRole(json['roles'] as Map<String, dynamic>),
    isPrivateProfile: json['isPrivateProfile'] as bool,
    showMyLocation: json['showMyLocation'] as bool,
    following: (json['following'] as Map)?.map(
      (k, e) => MapEntry(k as String, e),
    ),
    address1: json['address1'] == null
        ? null
        : Address.fromJson((json['address1'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    address2: json['address2'] == null
        ? null
        : Address.fromJson((json['address2'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    measurements: json['measurements'] == null
        ? null
        : Measurement.fromJson((json['measurements'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    online: json['online'] as bool ?? false,
    deviceToken: json['deviceToken'] as String,
    platform: json['platform'] as String,
    currency: json['currency'] as String ?? 'USD',
    badges: (json['badges'] as Map)?.map(
          (k, e) => MapEntry(k as String, e as bool),
        ) ??
        {},
    customerId: json['stripeCustomerId'] as String,
    customColors: (json['customColors'] as Map)?.map(
          (k, e) => MapEntry(k as String, e),
        ) ??
        {},
  );
}

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) {
  final val = <String, dynamic>{
    'uid': instance.id,
    'email': instance.email,
    'name': instance.name,
    'handle': instance.handle,
    'thumbnailUrl': instance.thumbnailUrl,
    'pictureUrl': instance.pictureUrl,
    'description': instance.description,
    'location': instance.location,
    'coverUrl': instance.coverUrl,
    'currency': instance.currency,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceToken', instance.deviceToken);
  writeNotNull('platform', instance.platform);
  val['isAnonymous'] = instance.isAnonymous;
  val['online'] = instance.online;
  val['roles'] = _rolesSerialization(instance.isDesigner);
  val['followingCount'] = instance.followingCount;
  val['followersCount'] = instance.followersCount;
  val['favouriteCount'] = instance.favouriteCount;
  val['designsCount'] = instance.designsCount;
  val['cartCount'] = instance.cartCount;
  val['messageCount'] = instance.messageCount;
  writeNotNull('isPrivateProfile', instance.isPrivateProfile);
  writeNotNull('showMyLocation', instance.showMyLocation);
  writeNotNull('following', instance.following);
  writeNotNull('follower', instance.follower);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('measurements', instance.measurements);
  writeNotNull('badges', instance.badges);
  writeNotNull('stripeCustomerId', instance.customerId);
  writeNotNull('customColors', instance.customColors);
  return val;
}
