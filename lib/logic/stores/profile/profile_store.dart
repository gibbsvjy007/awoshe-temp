import 'package:Awoshe/logic/api/feeds_api.dart';
import 'package:Awoshe/logic/api/profile_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/models/favourite/favourite.dart';
import 'package:Awoshe/models/order/designer_order_item.dart';
import 'package:Awoshe/models/order/order.dart';
import 'package:Awoshe/models/user/user.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  int fetchedFollowingsPage = 0;
  int fetchedFollowersPage = 0;
  int fetchedFavouritePage = 0;
  int fetchOrderPage = 0;
  int limit = 10;

  @observable
  bool loadingFollowingFollowers = false;

  @observable
  bool loadingFavourites = false;

  @observable
  bool loading = true;

  @observable
  bool loadingOrderDetail = true;

  @observable
  UserDetails userDetails;

  @observable
  ObservableStream isFollowing;

  @observable
  ObservableList followingList = ObservableList<User>();

  @observable
  ObservableList followerList = ObservableList<User>();

  @observable
  ObservableList followingListIds = ObservableList<String>();

  @observable
  ObservableList favouritesList = ObservableList<Favourite>();

  @observable
  ObservableList orderList = ObservableList<Order>();

  @observable
  Order currentOrder = Order.empty();

  @observable
  int currentDeliveryStatus = 0;

  @observable
  DesignerOrderItem currentDesignerOrder = DesignerOrderItem.empty();

  @action
  void setLoading(bool isLoading) {
    loading = isLoading;
  }

  @action
  void setOrderDetailLoading(bool isLoading) {
    loadingOrderDetail = isLoading;
  }

  @action
  void setUserDetails(UserDetails details) {
    userDetails = details;
  }

  @action
  void setFollowingList(List<User> l) {
    followingList.addAll(l);
  }

  @action
  void setFollowerList(List<User> l) {
    followerList.addAll(l);
  }

  @action
  void setFollowingLoading(bool isLoading) {
    loadingFollowingFollowers = isLoading;
  }

  @action
  void setFavouriteList(List<Favourite> f) {
    favouritesList.addAll(f);
  }

  @action
  void setOrderList(List<Order> f) {
    orderList.addAll(f);
  }

  @action
  void setCurrentOrder(Order o) {
    currentOrder = o;
  }

  @action
  void setDesignerCurrentOrder(DesignerOrderItem o) {
    currentDesignerOrder = o;
    setDeliveryStatus(currentDesignerOrder.deliveryStatus);
  }

  @action
  void setFavouriteLoading(bool l) {
    loadingFavourites = l;
  }

  @action
  void setDeliveryStatus(int s) {
    currentDeliveryStatus = s;
  }


  @computed
  bool get loadingFollowingFolloweFriends => loadingFollowingFollowers;

  @action
  Future<void> getUserProfile({String userId, String currentUserId}) async {
    try {
      UserDetails details = await ProfileApi.getUserProfile(userId: userId, currentUserId: currentUserId);
      setUserDetails(details);
    } 
    
    catch (ex){
      setUserDetails(null);
      //setLoading(false);
    }
    
  }

  Future<RestServiceResponse> contactDesigner({String designerId, Map<String, dynamic> oData, currentUserId}) async {
    RestServiceResponse response = await ProfileApi.contactDesinger(
        oData: oData,
        desingerId: designerId,
        currUserId: currentUserId);
    return response;
  }

  @action
  Future<void> deleteFavourite({String id, int index}) async {
    favouritesList.removeAt(index);
    await FeedsApi.unFavourite(productId: id, userId: userDetails.id);
    userDetails.favouriteCount--;
  }

  @action
  Future<void> fetchFollowing() async {
    setFollowingLoading(true);
    RestServiceResponse response = await ProfileApi.getFollowings(userId: userDetails.id, page: fetchedFollowingsPage, limit: limit);
    if (response.content != null && response.content.length > 0) {
      List<User> l = response.content.map<User>((dt) {
        User user = User.fromJson(dt);
        followingListIds.add(user.id);
        return user;
      }).toList();
      setFollowingList(l);
      fetchedFollowingsPage++;
    }
    setFollowingLoading(false);
  }

  @action
  Future<void> fetchFollower() async {
    setFollowingLoading(true);
    RestServiceResponse response = await ProfileApi.getFollowers(
        userId: userDetails.id, page: fetchedFavouritePage, limit: limit);
    if (response.content != null && response.content.length > 0) {
      List<User> l = response.content.map<User>((dt) {
        return User.fromJson(dt);
      }).toList();
      setFollowerList(l);
      fetchedFavouritePage++;
    }
    setFollowingLoading(false);
  }

  @action
  Future<void> fetchFavourites() async {
    setFavouriteLoading(true);
    RestServiceResponse response = await ProfileApi.getFavourites(
        userId: userDetails.id, page: fetchedFavouritePage, limit: limit);
    if (response.content != null && response.content.length > 0) {
      List<Favourite> l = response.content.map<Favourite>((dt) {
        return Favourite.fromJson(dt);
      }).toList();
      setFavouriteList(l);
      fetchedFavouritePage++;
    }
    setFavouriteLoading(false);
  }

  @action
  Future<void> fetchOrders() async {
    setLoading(true);
    RestServiceResponse response = await ProfileApi.fetchOrders(
        userId: userDetails.id, page: fetchOrderPage, limit: limit);
    if (response.content != null && response.content.length > 0) {
      List<Order> o = response.content.map<Order>((dt) {
        print(dt.toString());
        return Order.fromJson(dt);
      }).toList();
      setOrderList(o);
      fetchOrderPage++;
    }
    setLoading(false);
  }

  @action
  Future<void> fetchOrderDetail({String orderId}) async {
    setOrderDetailLoading(true);
    RestServiceResponse response = await ProfileApi.fetchOrderDetail(
        userId: userDetails.id, orderId: orderId);
    if (response.content != null) {
      print(response.content.toString());
      setCurrentOrder(Order.fromJson(response.content));
    }
    setOrderDetailLoading(false);
  }

  @action
  Future<void> fetchDesignerOrderDetail({String orderId}) async {
    setOrderDetailLoading(true);
    RestServiceResponse response = await ProfileApi.fetchOrderDetail(
        userId: userDetails.id, orderId: orderId);
    if (response.content != null) {
      print(response.content.toString());
      setDesignerCurrentOrder(DesignerOrderItem.fromJson(response.content));
    }
    setOrderDetailLoading(false);
  }

  @action
  Future<void> updateDeliveryStatus() async {
    Map<String, dynamic> oData = { 'deliveryStatus': currentDeliveryStatus};
    RestServiceResponse response = await ProfileApi.updateOrder(
        userId: userDetails.id, orderId: currentDesignerOrder.id, oData: oData);
    if (response.content != null) {
      print(response.content.toString());
    }
  }



}