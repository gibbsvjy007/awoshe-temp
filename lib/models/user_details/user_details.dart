import 'package:Awoshe/constants.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/measurement/measurement.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  @JsonKey(name: 'uid')
  final String id;
  final String email;
  final String name;
  final String handle;
  final String thumbnailUrl;
  final String pictureUrl;
  final String description;
  final String location;
  final String coverUrl;
  @JsonKey(defaultValue: 'USD')
  String currency;

  @JsonKey(includeIfNull: false)
  final String deviceToken;

  @JsonKey(includeIfNull: false)
  final String platform;

  @JsonKey(defaultValue: false, includeIfNull: true)
  final bool isAnonymous;

  @JsonKey(defaultValue: false)
  bool online;

  @JsonKey(
      fromJson: _getRole,
      toJson: _rolesSerialization,
      name: 'roles')
  final bool isDesigner;

  @JsonKey(defaultValue: 0)
  int followingCount;

  @JsonKey(defaultValue: 0)
  int followersCount;

  @JsonKey(defaultValue: 0)
  int favouriteCount;

  @JsonKey(defaultValue: 0)
  final int designsCount;

  @JsonKey(defaultValue: 0)
  int cartCount;

  @JsonKey(defaultValue: 0)
  int messageCount;

  @JsonKey(includeIfNull: false)
  final bool isPrivateProfile;

  @JsonKey(includeIfNull: false)
  final bool showMyLocation;

  @JsonKey(includeIfNull: false)
  final Map<String, dynamic> following;

  @JsonKey(includeIfNull: false)
  final Map<String, dynamic> follower;

  @JsonKey(includeIfNull: false)
  Address address1;

  @JsonKey(includeIfNull: false)
  Address address2;

  @JsonKey(includeIfNull: false)
  Measurement measurements;

  @JsonKey(
    includeIfNull: false,
    defaultValue: {},
  )
  Map<String, bool> badges;

  @JsonKey(
    name: 'stripeCustomerId',
    includeIfNull: false
    )
  final String customerId;

  @JsonKey(
    includeIfNull: false,
    defaultValue: {}
  )
  Map<String,dynamic> customColors;

  UserDetails({
    @required this.id,
    @required this.email,
    @required this.name,
    this.isAnonymous,
    this.thumbnailUrl = '',
    this.handle = '',
    this.pictureUrl = '',
    this.coverUrl = '',
    this.description = '',
    this.location = '',
    this.followingCount = 0,
    this.followersCount = 0,
    this.designsCount = 0,
    this.favouriteCount = 0,
    this.cartCount = 0,
    this.messageCount = 0,
    this.follower,
    this.isDesigner = false,
    this.isPrivateProfile = false,
    this.showMyLocation = false,
    this.following,
    this.address1,
    this.address2,
    this.measurements,
    this.online,
    this.deviceToken,
    this.platform,
    this.currency,
    this.badges,
    this.customerId,
    this.customColors,
  });

  factory UserDetails.empty() {
    return UserDetails(
        id: '',
        email: '',
        name: '',
        handle: '',
        description: '',
        location: '',
        isAnonymous: false,
        badges: {},
        currency: DEFAULT_CURRENCY, // default currency is USD.
    );
  }

  getUser() {
    User user = User(id: this.id, name: this.name, thumbnailUrl: this.thumbnailUrl, online: this.online, handle: this.handle);
    return user;
  }

  UserDetails copyWith({
    String email,
    bool isAnonymous,
    String name,
    String handle,
    String pictureUrl,
    String thumbnailUrl,
    String coverUrl,
    String location,
    bool isDesigner,
    String description,
    Map<String, dynamic> following,
    Map<String, dynamic> follower,
    int followersCount,
    int followingCount,
    int designsCount,
    int favouriteCount,
    int cartCount,
    int messageCount,
    Address address1,
    Address address2,
    Measurement measurements,
    bool online,
    String deviceToken,
    String platform,
    String currency,
    Map<String, bool> badges,
    String customerId,
    Map<String,dynamic> customColors,
  }) {
    return UserDetails(
        id: this.id,
        email: email ?? this.email,
        isAnonymous: isAnonymous ?? this.isAnonymous,
        handle: handle ?? this.handle,
        name: name ?? this.name,
        location: location ?? this.location,
        coverUrl: coverUrl ?? this.coverUrl,
        pictureUrl: pictureUrl ?? this.pictureUrl,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        isDesigner: isDesigner ?? this.isDesigner,
        description: description ?? this.description,
        designsCount: designsCount ?? this.designsCount,
        followingCount: followingCount ?? this.followingCount,
        followersCount: followersCount ?? this.followersCount,
        favouriteCount: favouriteCount ?? this.favouriteCount,
        cartCount: cartCount ?? this.cartCount,
        messageCount: messageCount ?? this.messageCount,
        follower: follower ?? this.follower,
        following: following ?? this.following,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        measurements: measurements ?? this.measurements,
        online: online ?? this.online,
        deviceToken: deviceToken ?? this.deviceToken,
        platform: platform ?? this.platform,
      currency: currency ?? this.currency ?? DEFAULT_CURRENCY,
      badges: badges ?? this.badges,
      customerId: customerId ?? this.customerId,
      customColors:  customColors ?? this.customColors,
    );
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}

bool _getRole(Map<String, dynamic> roles) {
  print('_getRole_________');
  print(roles.toString());
//  print(roles['designer']);
  return roles != null && roles['designer'] != null ? roles['designer'] : false;
}

Map<String, dynamic> _rolesSerialization(bool isDesigner) {
  return (isDesigner) ? {'designer': true, 'user': false, 'admin': false} :
  {'designer': false, 'user': true, 'admin': false};
}


