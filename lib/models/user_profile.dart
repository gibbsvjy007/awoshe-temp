import 'package:cloud_firestore/cloud_firestore.dart';

enum ProfilePhotoType {COVER, PROFILE}

class UserProfile {
  String username;
  String fullName;
  String aboutMe;
  bool online;
  DocumentReference documentReference;
  ProfileImage images = new ProfileImage("", "");
//  Addresses addresses = new Addresses("", "", "", "", "", "", 0, false, false);

  UserProfile(
      {this.username,
      this.fullName,
      this.aboutMe,
      this.online,
      this.images});

  UserProfile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        fullName = json['fullName'],
        aboutMe = json['aboutMe'],
        online = json['online'],
        images = ProfileImage.fromJson(json['images']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'fullName': fullName,
        'aboutMe': aboutMe,
        'images': images.toJson()
      };

  UserProfile.data(this.documentReference,
      [this.username,
      this.fullName,
      this.aboutMe,
      this.online,
      this.images]) {
    this.username ??= '';
    this.fullName ??= '';
    this.online ??= false;
    this.images ??= ProfileImage.fromJson(null);
    this.aboutMe ??= '';
  }
  factory UserProfile.fromDocument(DocumentSnapshot document) =>
      UserProfile.data(
          document != null ? document.reference : null,
          document.data['username'],
          document.data['fullName'],
          document.data['aboutMe'],
          document.data['online'],
          ProfileImage.fromJson(document.data['images']));
}

class ProfileImage {
  String coverUrl;
  String profileUrl;
  ProfileImage(this.coverUrl, this.profileUrl);

  ProfileImage.fromJson(Map<dynamic, dynamic> json)
      : coverUrl = json != null ? json['coverUrl'] : "",
        profileUrl =
            json != null ? json['profileUrl'] : "";

  Map<String, String> toJson() =>
      {'coverUrl': coverUrl, 'profileUrl': profileUrl};
}

class Addresses {
  String id;
  String fullName;
  String street;
  String city;
  String state;
  String zipCode;
  String country;
  int type;
  bool isDeleted;
  bool isDefault;

  Addresses(
      {this.id = "",
        this.fullName = "",
      this.street = "",
      this.city = "",
      this.state = "",
      this.zipCode = "",
      this.country = "",
      this.type = 0,
      this.isDeleted = false,
      this.isDefault = false});

  Addresses.fromJson(Map<dynamic, dynamic> json)
      : id = json != null ? json['id']: "",
        fullName = json != null ? json['fullName'] : "",
        street = json != null ? json['street'] : "",
        city = json != null ? json['city'] : "",
        state = json != null ? json['state'] : "",
        zipCode = json != null ? json['zipCode'] : "",
        country = json != null ? json['country'] : "",
        type = json != null ? json['type'] : 0,
        isDeleted = json != null ? json['isDeleted'] : false,
        isDefault = json != null ? json['isDefault'] : false;

  Addresses.fromDocument(DocumentSnapshot doc)
      : id = doc.documentID,
        fullName = doc['fullName'],
        street = doc != null ? doc['street'] : "",
        city = doc != null ? doc['city'] : "",
        state = doc != null ? doc['state'] : "",
        zipCode = doc != null ? doc['zipCode'] : "",
        country = doc != null ? doc['country'] : "",
        type = doc != null ? doc['type'] : 0,
        isDeleted = doc != null ? doc['isDeleted'] : false,
        isDefault = doc != null ? doc['isDefault'] : false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'street': street,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'country': country,
        'type': type,
        'isDeleted': isDeleted,
        'isDefault': isDefault
      };
}

class Measurements {
  double height;
  double hip;
  double chest;
  double waist;
  double burst;
  double arms;
  Measurements(
      this.height, this.hip, this.chest, this.waist, this.burst, this.arms);

  Measurements.fromJson(Map<String, dynamic> json)
      : height = json != null ? ['height'] : 0.0,
        hip = json != null ? json['hip'] : 0.0,
        chest = json != null ? json['chest'] : 0.0,
        waist = json != null ? json['waist'] : 0.0,
        arms = json != null ? json['arms'] : 0.0,
        burst = json != null ? json['burst'] : 0.0;

  Map<String, dynamic> toJson() => {
        'height': height,
        'hip': hip,
        'chest': chest,
        'waist': waist,
        'arms': arms,
        'burst': burst
      };
}
