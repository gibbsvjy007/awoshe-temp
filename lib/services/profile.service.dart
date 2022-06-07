import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Awoshe/models/user_profile.dart';


class ProfileService {

  final String userId;
  final DocumentReference profileRef;
  final DocumentReference profileGeneralRef;
  final CollectionReference profileAddressCollectionRef;
  final CollectionReference profileMeasurementsRef;
  final CollectionReference messagingTokenRef;

//  static final String PROFILE = "";
//  static final String SETTINGS = "";
//
  ProfileService(this.userId)
      : profileRef = Firestore.instance.document("profiles/$userId"),
        profileGeneralRef =
            Firestore.instance.document("profiles/$userId/settings/general"),
        profileAddressCollectionRef =
            Firestore.instance.collection("profiles/$userId/addresses"),
        profileMeasurementsRef =
            Firestore.instance.collection("profiles/$userId/measurements"),
        messagingTokenRef =
            Firestore.instance.collection('profiles/$userId/messagingToken');

  Future<UserProfile> getUserProfile() async {
    DocumentSnapshot userData = await this.profileRef.get();
    UserProfile userProfile = new UserProfile.fromDocument(userData);
    return userProfile;
  }

  static Future<UserProfile> getProfileByUserId(String userId) async {
    DocumentSnapshot userData = await Firestore.instance.document("profiles/$userId").get();
    UserProfile userProfile = new UserProfile.fromDocument(userData);
    return userProfile;
  }

  static Stream<DocumentSnapshot> getProfileStreamByUserId(final String userId) =>
      Firestore.instance.document("profiles/$userId").snapshots();

  static Stream<QuerySnapshot> getFollowersByUserId(final String userId) =>
      Firestore.instance.collection("profiles/$userId/followers").snapshots();

  static Stream<QuerySnapshot> getFollowingByUserId(final String userId) =>
      Firestore.instance.collection("profiles/$userId/following").snapshots();

  static Stream<QuerySnapshot> getDesignsByUserId(final String userId) =>
      Firestore.instance.collection("profiles/$userId/designs").snapshots();

  static Stream<QuerySnapshot> getFavouritesByUserId(final String userId) =>
      Firestore.instance.collection("profiles/$userId/favourites").snapshots();

  /// This method verifies if user of [myUserId] is following the user [targetUserId]
  /// [myUserId] My user Id or current user id.
  /// [targetUserId] The user id that you want know if you're following or not.
  static Stream<DocumentSnapshot> amIFollowingUser(final String myUserId, final String targetUserId) {
    return Firestore.instance.collection('profiles/$myUserId/following')
        .document('$targetUserId').snapshots();
  }

  Future<void> updatePhoto<ProfileImage>(ProfilePhotoType type, String photoUrl) async {
    print('update photo');
    UserProfile userProfile = await this.getUserProfile();
    if (type == ProfilePhotoType.COVER) {
      userProfile.images.coverUrl = photoUrl;
    } else {
      userProfile.images.profileUrl = photoUrl;
    }
    try {
      return this.profileRef.setData(userProfile.toJson(), merge: true);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> updateUserNames<UserProfile>(userData) async {
    try {
      print(userData);
      print(userId);
      return this.profileRef.setData(userData, merge: true);
      //return this.profileGeneralRef.setData(userData, merge: true);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> addUserAddress(address) async {
    try {
      return this.profileAddressCollectionRef.add(address).then((ref) {
        print(ref.get());
        return ref.get();
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<Addresses> getAddress(addressId) async {
    try {
      DocumentSnapshot snapshot = await Firestore.instance
          .document("profiles/$userId/addresses/$addressId")
          .get();
      Addresses address = Addresses.fromDocument(snapshot);
      return address;
    } catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<void> updateAddress(addressId, data) async {
    try {
      await Firestore.instance
          .document("profiles/$userId/addresses/$addressId")
          .updateData(data);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> deleteAddress<Addresses>(addressId) async {
    try {
      return Firestore.instance
          .document("profiles/$userId/addresses/$addressId")
          .setData({"isDeleted": true}, merge: true);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> addMeasurements(measurements) async {
    try {
      return this.profileMeasurementsRef.add(measurements).then((ref) {
        print(ref.get());
        return ref.get();
      });
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> updateMeasurements(measurementId, data) async {
    try {
      Firestore.instance
          .document("profiles/$userId/measurements/$measurementId")
          .updateData(data)
          .then((response) {});
    } catch (e) {
      print(e.message);
    }
  }

  registerToken(String token) {
    print("_________registering token_________");
    print(token);
    messagingTokenRef.document('messagingToken').setData({
      'messagingToken': token,
      'updatedAt': DateTime.now()
    }).catchError((error) {
      print(error);
    });
  }

  static unFollowUser(final String userId, final String unfollowId) {
    Firestore.instance.collection('profiles/$userId/following').document('$unfollowId').delete();
    Firestore.instance.collection('profiles/$unfollowId/followers')
        .document('$userId').delete();
  }

  static followUser(final String userId, final String targetUserId) {
    print('vijay id $targetUserId');
    Firestore.instance.collection('profiles/$userId/following')
        .document('$targetUserId').setData({'target': '$targetUserId', 'createdAt': DateTime.now()});


  }

  Stream<QuerySnapshot> getProfileDesigns() {
    return Firestore.instance
        .collection("profiles/$userId/designs")
        .snapshots();
  }
}

