import 'dart:async';

import 'package:Awoshe/logic/api/profile_api.dart';
import 'package:Awoshe/logic/api/user_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/services/OfferService.dart';
import 'package:Awoshe/models/address/address.dart';
import 'package:Awoshe/models/rating_review/RatingReview.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  List<String> viewedFriendsPosts = [];
  final OfferService offerService = OfferService();

  int fetchedFriendsPage = 0;
  int fetchedUserListPage = 0;

  @observable
  bool allFriendsFetched = false;

  @observable
  bool allUserListsFetched = false;

  @observable
  bool loading = false;

  @observable
  UserDetails details = UserDetails.empty();

  @observable
  ObservableList<String> followingUserIds = ObservableList<String>();

  @observable
  ObservableList<String> friendRequestList = ObservableList<String>();

  @observable
  ObservableList<String> blockedUserIds = ObservableList<String>();

  @observable
  ObservableFuture<bool> createListFuture;

  static User _supportUser;

  StreamSubscription<DocumentSnapshot> _messageCountSubscription;

  @action
  setUserDetails(UserDetails userDetails) {
    details = userDetails;
  }

  @action
  void setLoading(bool isLoading) {
    loading = isLoading;
  }

  @action
  void addFollowingUserId(String id) {
    followingUserIds.add(id);
  }

  @action
  void removeFollowingUserId(String id) {
    followingUserIds.remove(id);
  }

  Future<void> followUser(String followingId) async {
    // addFollowingUserId(followingId);
    try {
      RestServiceResponse response = await ProfileApi.followUser(
        followingId: followingId, currUserId: details.id);
      if (response.success) {
        details.followingCount++;
        addFollowingUserId(followingId);
      }
    } catch (ex){
      //details.followingCount--;
      //removeFollowingUserId(followingId);
      print(ex);
    }
    
  }

  /// returns true if added the color with success.
  /// This method automatically updates the data in database.
  bool addCustomColor(String colorName, int colorValue) {
    var contains = details.customColors.containsKey(colorName);
    // if the color already is in the map, we cant add a new one with the same name.
    if (contains)
      return !contains;
    
    details.customColors.putIfAbsent( colorName, () => colorValue );
    
    UserApi.updateUserInfo(
      currUserId: this.details.id,
      oData: details.toJson()
    );

    return !contains;
  }

  Future<void> unFollowUser(String followingId) async {
    try {
      RestServiceResponse response = await ProfileApi.unFollowUser(
        followingId: followingId, currUserId: details.id);
      if (response.success) {
        details.followingCount--;
        removeFollowingUserId(followingId);
      }
    } catch (ex){
      // details.followingCount--;
      // removeFollowingUserId(followingId);
      print(ex);
    }
  }


  Future<void> updateDeviceToken(String deviceToken) async {
    Map<String, dynamic> oData = Map();
    oData['deviceToken'] = deviceToken;
    RestServiceResponse response = await ProfileApi.updateProfile(
        oData: oData,
        currUserId: details.id);
    if (response.success) {
      print("Device Token Updated Successfully............");
    }
    return response;
  }

  Future<RestServiceResponse> updateProfile(Map<String, dynamic> oData) async {
    RestServiceResponse response = await ProfileApi.updateProfile(
        oData: oData,
        currUserId: details.id);
    return response;
  }

  Future<RestServiceResponse> saveProfile(
      {String handle, String location, String description, String name}) async {
    RestServiceResponse response = await ProfileApi.saveProfile(
        name: name,
        handle: handle,
        description: description,
        location: location,
        currUserId: details.id);
    return response;
  }

  Future<void> setPresence(bool isOnline) async {
    RestServiceResponse response = await UserApi.setPresence(
        isActive: isOnline,
        currUserId: details.id);
    if (response.success)
      print("________User is " + isOnline.toString() + ' now________________');
    return response;
  }

  Future<void> updateShippingAddress(Address address) async {
    setUserDetails(details.copyWith(
        address1: address
    ));
    return updateProfile(details.toJson());
  }

  Future<void> updateBillingAddress(Address address) async {
    setUserDetails(details.copyWith(
        address2: address
    ));
    
    return updateProfile(details.toJson());
  }

  Future<void> sendProductReview(String productId,
    {double experienceRating, double designerRating,
      double productRating, String description}) async {

    var review = RatingReview(
      designerRating: designerRating,
      experienceRating: experienceRating,
      productRating: productRating,
      ratingDesc: description
    );


    UserApi.submitProductReview(
        productId: productId,
        userId: details.id,
        data: review.toJson()
    );
  }

  Future<void> resetMessageCount() async {
    await UserApi.resetMessageCount(
        userId: details.id,
    );
  }

  Future<User> getSupportUser() async {

    try {
      if (_supportUser == null){
        final _supportUID = 'rMhvDZxhgrQM1mgMN2GhXRm28D92';
        var details = await UserApi.getUserProfile(loggerInUser: _supportUID);

        _supportUser = User(
            id: details.id,
            name: details.name ?? 'Awoshe Support',
            thumbnailUrl: details.thumbnailUrl,
            handle: details.handle,
            online: details.online
        );
      }

      return _supportUser;
    }
    catch (ex){
      print('Error in UserStore::getSupportUser() $ex');
      throw ex;
    }

  }

  StreamSubscription<DocumentSnapshot> subscribeToMessageCount() {
    print('subscribeToMessageCount start');

    try {
      _messageCountSubscription =
          UserApi.listenMessageCount(userId: details.id).listen(messageListnerFn);

    } catch (ex){
      print(ex);
    }
    return _messageCountSubscription;
  }

  void unSubscribeToMessageCount() {
    _messageCountSubscription?.cancel();
  }

  void messageListnerFn(DocumentSnapshot documentSnapshot) async {
    print("__________________messageListnerFn invoked");
    print(documentSnapshot.data);
    if (documentSnapshot.data != null && documentSnapshot.data['messageCount'] != null) {
      UserDetails updatedDetails = details.copyWith(
        messageCount: documentSnapshot.data['messageCount']
      );
      setUserDetails(updatedDetails);
    }
  }
}
