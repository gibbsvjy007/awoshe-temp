// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$allFriendsFetchedAtom = Atom(name: '_UserStore.allFriendsFetched');

  @override
  bool get allFriendsFetched {
    _$allFriendsFetchedAtom.context.enforceReadPolicy(_$allFriendsFetchedAtom);
    _$allFriendsFetchedAtom.reportObserved();
    return super.allFriendsFetched;
  }

  @override
  set allFriendsFetched(bool value) {
    _$allFriendsFetchedAtom.context.conditionallyRunInAction(() {
      super.allFriendsFetched = value;
      _$allFriendsFetchedAtom.reportChanged();
    }, _$allFriendsFetchedAtom, name: '${_$allFriendsFetchedAtom.name}_set');
  }

  final _$allUserListsFetchedAtom =
      Atom(name: '_UserStore.allUserListsFetched');

  @override
  bool get allUserListsFetched {
    _$allUserListsFetchedAtom.context
        .enforceReadPolicy(_$allUserListsFetchedAtom);
    _$allUserListsFetchedAtom.reportObserved();
    return super.allUserListsFetched;
  }

  @override
  set allUserListsFetched(bool value) {
    _$allUserListsFetchedAtom.context.conditionallyRunInAction(() {
      super.allUserListsFetched = value;
      _$allUserListsFetchedAtom.reportChanged();
    }, _$allUserListsFetchedAtom,
        name: '${_$allUserListsFetchedAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_UserStore.loading');

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

  final _$detailsAtom = Atom(name: '_UserStore.details');

  @override
  UserDetails get details {
    _$detailsAtom.context.enforceReadPolicy(_$detailsAtom);
    _$detailsAtom.reportObserved();
    return super.details;
  }

  @override
  set details(UserDetails value) {
    _$detailsAtom.context.conditionallyRunInAction(() {
      super.details = value;
      _$detailsAtom.reportChanged();
    }, _$detailsAtom, name: '${_$detailsAtom.name}_set');
  }

  final _$followingUserIdsAtom = Atom(name: '_UserStore.followingUserIds');

  @override
  ObservableList<String> get followingUserIds {
    _$followingUserIdsAtom.context.enforceReadPolicy(_$followingUserIdsAtom);
    _$followingUserIdsAtom.reportObserved();
    return super.followingUserIds;
  }

  @override
  set followingUserIds(ObservableList<String> value) {
    _$followingUserIdsAtom.context.conditionallyRunInAction(() {
      super.followingUserIds = value;
      _$followingUserIdsAtom.reportChanged();
    }, _$followingUserIdsAtom, name: '${_$followingUserIdsAtom.name}_set');
  }

  final _$friendRequestListAtom = Atom(name: '_UserStore.friendRequestList');

  @override
  ObservableList<String> get friendRequestList {
    _$friendRequestListAtom.context.enforceReadPolicy(_$friendRequestListAtom);
    _$friendRequestListAtom.reportObserved();
    return super.friendRequestList;
  }

  @override
  set friendRequestList(ObservableList<String> value) {
    _$friendRequestListAtom.context.conditionallyRunInAction(() {
      super.friendRequestList = value;
      _$friendRequestListAtom.reportChanged();
    }, _$friendRequestListAtom, name: '${_$friendRequestListAtom.name}_set');
  }

  final _$blockedUserIdsAtom = Atom(name: '_UserStore.blockedUserIds');

  @override
  ObservableList<String> get blockedUserIds {
    _$blockedUserIdsAtom.context.enforceReadPolicy(_$blockedUserIdsAtom);
    _$blockedUserIdsAtom.reportObserved();
    return super.blockedUserIds;
  }

  @override
  set blockedUserIds(ObservableList<String> value) {
    _$blockedUserIdsAtom.context.conditionallyRunInAction(() {
      super.blockedUserIds = value;
      _$blockedUserIdsAtom.reportChanged();
    }, _$blockedUserIdsAtom, name: '${_$blockedUserIdsAtom.name}_set');
  }

  final _$createListFutureAtom = Atom(name: '_UserStore.createListFuture');

  @override
  ObservableFuture<bool> get createListFuture {
    _$createListFutureAtom.context.enforceReadPolicy(_$createListFutureAtom);
    _$createListFutureAtom.reportObserved();
    return super.createListFuture;
  }

  @override
  set createListFuture(ObservableFuture<bool> value) {
    _$createListFutureAtom.context.conditionallyRunInAction(() {
      super.createListFuture = value;
      _$createListFutureAtom.reportChanged();
    }, _$createListFutureAtom, name: '${_$createListFutureAtom.name}_set');
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  dynamic setUserDetails(UserDetails userDetails) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setUserDetails(userDetails);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addFollowingUserId(String id) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.addFollowingUserId(id);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFollowingUserId(String id) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.removeFollowingUserId(id);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }
}
