// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedsStore on _FeedsStore, Store {
  final _$loadingAtom = Atom(name: '_FeedsStore.loading');

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

  final _$allFeedsFetchedAtom = Atom(name: '_FeedsStore.allFeedsFetched');

  @override
  bool get allFeedsFetched {
    _$allFeedsFetchedAtom.context.enforceReadPolicy(_$allFeedsFetchedAtom);
    _$allFeedsFetchedAtom.reportObserved();
    return super.allFeedsFetched;
  }

  @override
  set allFeedsFetched(bool value) {
    _$allFeedsFetchedAtom.context.conditionallyRunInAction(() {
      super.allFeedsFetched = value;
      _$allFeedsFetchedAtom.reportChanged();
    }, _$allFeedsFetchedAtom, name: '${_$allFeedsFetchedAtom.name}_set');
  }

  final _$newFeedAvailableAtom = Atom(name: '_FeedsStore.newFeedAvailable');

  @override
  bool get newFeedAvailable {
    _$newFeedAvailableAtom.context.enforceReadPolicy(_$newFeedAvailableAtom);
    _$newFeedAvailableAtom.reportObserved();
    return super.newFeedAvailable;
  }

  @override
  set newFeedAvailable(bool value) {
    _$newFeedAvailableAtom.context.conditionallyRunInAction(() {
      super.newFeedAvailable = value;
      _$newFeedAvailableAtom.reportChanged();
    }, _$newFeedAvailableAtom, name: '${_$newFeedAvailableAtom.name}_set');
  }

  final _$feedsAtom = Atom(name: '_FeedsStore.feeds');

  @override
  ObservableList<dynamic> get feeds {
    _$feedsAtom.context.enforceReadPolicy(_$feedsAtom);
    _$feedsAtom.reportObserved();
    return super.feeds;
  }

  @override
  set feeds(ObservableList<dynamic> value) {
    _$feedsAtom.context.conditionallyRunInAction(() {
      super.feeds = value;
      _$feedsAtom.reportChanged();
    }, _$feedsAtom, name: '${_$feedsAtom.name}_set');
  }

  final _$bannerFeedsAtom = Atom(name: '_FeedsStore.bannerFeeds');

  @override
  ObservableList<dynamic> get bannerFeeds {
    _$bannerFeedsAtom.context.enforceReadPolicy(_$bannerFeedsAtom);
    _$bannerFeedsAtom.reportObserved();
    return super.bannerFeeds;
  }

  @override
  set bannerFeeds(ObservableList<dynamic> value) {
    _$bannerFeedsAtom.context.conditionallyRunInAction(() {
      super.bannerFeeds = value;
      _$bannerFeedsAtom.reportChanged();
    }, _$bannerFeedsAtom, name: '${_$bannerFeedsAtom.name}_set');
  }

  final _$toggleFavouriteAsyncAction = AsyncAction('toggleFavourite');

  @override
  Future<void> toggleFavourite(
      {Feed feed, String userId, UserStore userStore}) {
    return _$toggleFavouriteAsyncAction.run(() => super
        .toggleFavourite(feed: feed, userId: userId, userStore: userStore));
  }

  final _$_FeedsStoreActionController = ActionController(name: '_FeedsStore');

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_FeedsStoreActionController.startAction();
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_FeedsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFeeds(List<Feed> f, {bool reset = false}) {
    final _$actionInfo = _$_FeedsStoreActionController.startAction();
    try {
      return super.setFeeds(f, reset: reset);
    } finally {
      _$_FeedsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBannerFeeds(List<Feed> f, {bool reset = false}) {
    final _$actionInfo = _$_FeedsStoreActionController.startAction();
    try {
      return super.setBannerFeeds(f, reset: reset);
    } finally {
      _$_FeedsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeNewFeedsWidget() {
    final _$actionInfo = _$_FeedsStoreActionController.startAction();
    try {
      return super.closeNewFeedsWidget();
    } finally {
      _$_FeedsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showNewFeedsWidget() {
    final _$actionInfo = _$_FeedsStoreActionController.startAction();
    try {
      return super.showNewFeedsWidget();
    } finally {
      _$_FeedsStoreActionController.endAction(_$actionInfo);
    }
  }
}
