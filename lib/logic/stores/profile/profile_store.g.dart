// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool> _$loadingFollowingFolloweFriendsComputed;

  @override
  bool get loadingFollowingFolloweFriends =>
      (_$loadingFollowingFolloweFriendsComputed ??=
              Computed<bool>(() => super.loadingFollowingFolloweFriends))
          .value;

  final _$loadingFollowingFollowersAtom =
      Atom(name: '_ProfileStore.loadingFollowingFollowers');

  @override
  bool get loadingFollowingFollowers {
    _$loadingFollowingFollowersAtom.context
        .enforceReadPolicy(_$loadingFollowingFollowersAtom);
    _$loadingFollowingFollowersAtom.reportObserved();
    return super.loadingFollowingFollowers;
  }

  @override
  set loadingFollowingFollowers(bool value) {
    _$loadingFollowingFollowersAtom.context.conditionallyRunInAction(() {
      super.loadingFollowingFollowers = value;
      _$loadingFollowingFollowersAtom.reportChanged();
    }, _$loadingFollowingFollowersAtom,
        name: '${_$loadingFollowingFollowersAtom.name}_set');
  }

  final _$loadingFavouritesAtom = Atom(name: '_ProfileStore.loadingFavourites');

  @override
  bool get loadingFavourites {
    _$loadingFavouritesAtom.context.enforceReadPolicy(_$loadingFavouritesAtom);
    _$loadingFavouritesAtom.reportObserved();
    return super.loadingFavourites;
  }

  @override
  set loadingFavourites(bool value) {
    _$loadingFavouritesAtom.context.conditionallyRunInAction(() {
      super.loadingFavourites = value;
      _$loadingFavouritesAtom.reportChanged();
    }, _$loadingFavouritesAtom, name: '${_$loadingFavouritesAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_ProfileStore.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$loadingOrderDetailAtom =
      Atom(name: '_ProfileStore.loadingOrderDetail');

  @override
  bool get loadingOrderDetail {
    _$loadingOrderDetailAtom.context
        .enforceReadPolicy(_$loadingOrderDetailAtom);
    _$loadingOrderDetailAtom.reportObserved();
    return super.loadingOrderDetail;
  }

  @override
  set loadingOrderDetail(bool value) {
    _$loadingOrderDetailAtom.context.conditionallyRunInAction(() {
      super.loadingOrderDetail = value;
      _$loadingOrderDetailAtom.reportChanged();
    }, _$loadingOrderDetailAtom, name: '${_$loadingOrderDetailAtom.name}_set');
  }

  final _$userDetailsAtom = Atom(name: '_ProfileStore.userDetails');

  @override
  UserDetails get userDetails {
    _$userDetailsAtom.context.enforceReadPolicy(_$userDetailsAtom);
    _$userDetailsAtom.reportObserved();
    return super.userDetails;
  }

  @override
  set userDetails(UserDetails value) {
    _$userDetailsAtom.context.conditionallyRunInAction(() {
      super.userDetails = value;
      _$userDetailsAtom.reportChanged();
    }, _$userDetailsAtom, name: '${_$userDetailsAtom.name}_set');
  }

  final _$isFollowingAtom = Atom(name: '_ProfileStore.isFollowing');

  @override
  ObservableStream<dynamic> get isFollowing {
    _$isFollowingAtom.context.enforceReadPolicy(_$isFollowingAtom);
    _$isFollowingAtom.reportObserved();
    return super.isFollowing;
  }

  @override
  set isFollowing(ObservableStream<dynamic> value) {
    _$isFollowingAtom.context.conditionallyRunInAction(() {
      super.isFollowing = value;
      _$isFollowingAtom.reportChanged();
    }, _$isFollowingAtom, name: '${_$isFollowingAtom.name}_set');
  }

  final _$followingListAtom = Atom(name: '_ProfileStore.followingList');

  @override
  ObservableList<dynamic> get followingList {
    _$followingListAtom.context.enforceReadPolicy(_$followingListAtom);
    _$followingListAtom.reportObserved();
    return super.followingList;
  }

  @override
  set followingList(ObservableList<dynamic> value) {
    _$followingListAtom.context.conditionallyRunInAction(() {
      super.followingList = value;
      _$followingListAtom.reportChanged();
    }, _$followingListAtom, name: '${_$followingListAtom.name}_set');
  }

  final _$followerListAtom = Atom(name: '_ProfileStore.followerList');

  @override
  ObservableList<dynamic> get followerList {
    _$followerListAtom.context.enforceReadPolicy(_$followerListAtom);
    _$followerListAtom.reportObserved();
    return super.followerList;
  }

  @override
  set followerList(ObservableList<dynamic> value) {
    _$followerListAtom.context.conditionallyRunInAction(() {
      super.followerList = value;
      _$followerListAtom.reportChanged();
    }, _$followerListAtom, name: '${_$followerListAtom.name}_set');
  }

  final _$followingListIdsAtom = Atom(name: '_ProfileStore.followingListIds');

  @override
  ObservableList<dynamic> get followingListIds {
    _$followingListIdsAtom.context.enforceReadPolicy(_$followingListIdsAtom);
    _$followingListIdsAtom.reportObserved();
    return super.followingListIds;
  }

  @override
  set followingListIds(ObservableList<dynamic> value) {
    _$followingListIdsAtom.context.conditionallyRunInAction(() {
      super.followingListIds = value;
      _$followingListIdsAtom.reportChanged();
    }, _$followingListIdsAtom, name: '${_$followingListIdsAtom.name}_set');
  }

  final _$favouritesListAtom = Atom(name: '_ProfileStore.favouritesList');

  @override
  ObservableList<dynamic> get favouritesList {
    _$favouritesListAtom.context.enforceReadPolicy(_$favouritesListAtom);
    _$favouritesListAtom.reportObserved();
    return super.favouritesList;
  }

  @override
  set favouritesList(ObservableList<dynamic> value) {
    _$favouritesListAtom.context.conditionallyRunInAction(() {
      super.favouritesList = value;
      _$favouritesListAtom.reportChanged();
    }, _$favouritesListAtom, name: '${_$favouritesListAtom.name}_set');
  }

  final _$orderListAtom = Atom(name: '_ProfileStore.orderList');

  @override
  ObservableList<dynamic> get orderList {
    _$orderListAtom.context.enforceReadPolicy(_$orderListAtom);
    _$orderListAtom.reportObserved();
    return super.orderList;
  }

  @override
  set orderList(ObservableList<dynamic> value) {
    _$orderListAtom.context.conditionallyRunInAction(() {
      super.orderList = value;
      _$orderListAtom.reportChanged();
    }, _$orderListAtom, name: '${_$orderListAtom.name}_set');
  }

  final _$currentOrderAtom = Atom(name: '_ProfileStore.currentOrder');

  @override
  Order get currentOrder {
    _$currentOrderAtom.context.enforceReadPolicy(_$currentOrderAtom);
    _$currentOrderAtom.reportObserved();
    return super.currentOrder;
  }

  @override
  set currentOrder(Order value) {
    _$currentOrderAtom.context.conditionallyRunInAction(() {
      super.currentOrder = value;
      _$currentOrderAtom.reportChanged();
    }, _$currentOrderAtom, name: '${_$currentOrderAtom.name}_set');
  }

  final _$currentDeliveryStatusAtom =
      Atom(name: '_ProfileStore.currentDeliveryStatus');

  @override
  int get currentDeliveryStatus {
    _$currentDeliveryStatusAtom.context
        .enforceReadPolicy(_$currentDeliveryStatusAtom);
    _$currentDeliveryStatusAtom.reportObserved();
    return super.currentDeliveryStatus;
  }

  @override
  set currentDeliveryStatus(int value) {
    _$currentDeliveryStatusAtom.context.conditionallyRunInAction(() {
      super.currentDeliveryStatus = value;
      _$currentDeliveryStatusAtom.reportChanged();
    }, _$currentDeliveryStatusAtom,
        name: '${_$currentDeliveryStatusAtom.name}_set');
  }

  final _$currentDesignerOrderAtom =
      Atom(name: '_ProfileStore.currentDesignerOrder');

  @override
  DesignerOrderItem get currentDesignerOrder {
    _$currentDesignerOrderAtom.context
        .enforceReadPolicy(_$currentDesignerOrderAtom);
    _$currentDesignerOrderAtom.reportObserved();
    return super.currentDesignerOrder;
  }

  @override
  set currentDesignerOrder(DesignerOrderItem value) {
    _$currentDesignerOrderAtom.context.conditionallyRunInAction(() {
      super.currentDesignerOrder = value;
      _$currentDesignerOrderAtom.reportChanged();
    }, _$currentDesignerOrderAtom,
        name: '${_$currentDesignerOrderAtom.name}_set');
  }

  final _$getUserProfileAsyncAction = AsyncAction('getUserProfile');

  @override
  Future<void> getUserProfile({String userId, String currentUserId}) {
    return _$getUserProfileAsyncAction.run(() =>
        super.getUserProfile(userId: userId, currentUserId: currentUserId));
  }

  final _$deleteFavouriteAsyncAction = AsyncAction('deleteFavourite');

  @override
  Future<void> deleteFavourite({String id, int index}) {
    return _$deleteFavouriteAsyncAction
        .run(() => super.deleteFavourite(id: id, index: index));
  }

  final _$fetchFollowingAsyncAction = AsyncAction('fetchFollowing');

  @override
  Future<void> fetchFollowing() {
    return _$fetchFollowingAsyncAction.run(() => super.fetchFollowing());
  }

  final _$fetchFollowerAsyncAction = AsyncAction('fetchFollower');

  @override
  Future<void> fetchFollower() {
    return _$fetchFollowerAsyncAction.run(() => super.fetchFollower());
  }

  final _$fetchFavouritesAsyncAction = AsyncAction('fetchFavourites');

  @override
  Future<void> fetchFavourites() {
    return _$fetchFavouritesAsyncAction.run(() => super.fetchFavourites());
  }

  final _$fetchOrdersAsyncAction = AsyncAction('fetchOrders');

  @override
  Future<void> fetchOrders() {
    return _$fetchOrdersAsyncAction.run(() => super.fetchOrders());
  }

  final _$fetchOrderDetailAsyncAction = AsyncAction('fetchOrderDetail');

  @override
  Future<void> fetchOrderDetail({String orderId}) {
    return _$fetchOrderDetailAsyncAction
        .run(() => super.fetchOrderDetail(orderId: orderId));
  }

  final _$fetchDesignerOrderDetailAsyncAction =
      AsyncAction('fetchDesignerOrderDetail');

  @override
  Future<void> fetchDesignerOrderDetail({String orderId}) {
    return _$fetchDesignerOrderDetailAsyncAction
        .run(() => super.fetchDesignerOrderDetail(orderId: orderId));
  }

  final _$updateDeliveryStatusAsyncAction = AsyncAction('updateDeliveryStatus');

  @override
  Future<void> updateDeliveryStatus() {
    return _$updateDeliveryStatusAsyncAction
        .run(() => super.updateDeliveryStatus());
  }

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderDetailLoading(bool isLoading) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setOrderDetailLoading(isLoading);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserDetails(UserDetails details) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setUserDetails(details);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFollowingList(List<User> l) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setFollowingList(l);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFollowerList(List<User> l) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setFollowerList(l);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFollowingLoading(bool isLoading) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setFollowingLoading(isLoading);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavouriteList(List<Favourite> f) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setFavouriteList(f);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderList(List<Order> f) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setOrderList(f);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentOrder(Order o) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setCurrentOrder(o);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDesignerCurrentOrder(DesignerOrderItem o) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setDesignerCurrentOrder(o);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavouriteLoading(bool l) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setFavouriteLoading(l);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeliveryStatus(int s) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction();
    try {
      return super.setDeliveryStatus(s);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }
}
