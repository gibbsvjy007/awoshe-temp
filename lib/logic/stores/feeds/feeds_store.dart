import 'dart:async';

import 'package:Awoshe/logic/api/feeds_api.dart';
import 'package:Awoshe/logic/restclient/rest_service_response.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'feeds_store.g.dart';

class FeedsStore = _FeedsStore with _$FeedsStore;

const int FEEDS_FETCH_LIMIT = 10;

abstract class _FeedsStore with Store {
  bool _firstNotification = true;

  @observable
  bool loading = false;

  int fetchFeedsPage = 0;

  @observable
  bool allFeedsFetched = false;

  @observable
  bool newFeedAvailable = false;

  @observable
  ObservableList feeds = ObservableList<Feed>();

  @observable
  ObservableList bannerFeeds = ObservableList<Feed>();

  bool isFeedSubscribed = false;

  StreamSubscription<QuerySnapshot> _newsFeedSubscription;

  @action
  void setLoading(bool isLoading) {
    loading = isLoading;
  }

  @action
  void setFeeds(List<Feed> f, {bool reset = false}) {
    if (reset) {
      feeds.clear();
      feeds.addAll(f);
    } else {
      feeds.addAll(f);
    }
  }

  @action
  void setBannerFeeds(List<Feed> f, {bool reset = false}) {
    if (reset) {
      bannerFeeds.clear();
      bannerFeeds.addAll(f);
    } else {
      bannerFeeds.addAll(f);
    }
  }


  @action
  void closeNewFeedsWidget() {
    newFeedAvailable = false;
    _firstNotification = false;
  }

  @action
  void showNewFeedsWidget() {
    newFeedAvailable = true;
  }

  Future<void> refreshFeeds(String userId) async {
    fetchFeedsPage = 0;
    await fetchFeeds(userId, fetchLatest: true);
  }

  Future<void> fetchLatest(userId) async {
    if (newFeedAvailable) closeNewFeedsWidget();
    await refreshFeeds(userId);
  }

  Future<void> fetchFeeds(String userId, {bool fetchLatest = false}) async {
    if (!fetchLatest) setLoading(true);
    try {
      this.fetchBannerFeeds(userId, fetchLatest: fetchLatest);

      /// fetch banner feeds parallely
      RestServiceResponse response = await FeedsApi.fetchFeeds(
          userId: userId, page: fetchFeedsPage, limit: FEEDS_FETCH_LIMIT);
      if (response.success) {
        var content = response.content;

        final List<Feed> feedsData = (content != null) ? content.map<Feed>((f) {
          //print(f.toString());
          return Feed.fromJson(f);
        }).toList() : [];

        setFeeds(feedsData, reset: fetchLatest);
        fetchFeedsPage++;
        if (feedsData.length < FEEDS_FETCH_LIMIT) {
          allFeedsFetched = true;
        }
      }
    } catch (e) {
      print("error");
      print(e);
    }

    setLoading(false);
  }

  Future<void> fetchBannerFeeds(String userId,
      {bool fetchLatest = false}) async {
    try {
      RestServiceResponse response = await FeedsApi.fetchBannerFeeds(
          userId: userId, page: 0, limit: FEEDS_FETCH_LIMIT);
      if (response.success) {
        print("Banner feeds fetched successfully.....");
        final List<Feed> feedsData = response.content.map<Feed>((f) {
          print(f.toString());
          return Feed.fromJson(f);
        }).toList();
        setBannerFeeds(feedsData, reset: fetchLatest);
      }
    } catch (e) {
      print("fetchBannerFeeds");
      print(e);
    }
  }

  @action
  Future<void> toggleFavourite(
      {Feed feed, String userId, UserStore userStore}) async {
    if (feed.isFavourited) {
      feed.isFavourited = false;
      await FeedsApi.unFavourite(productId: feed.id, userId: userId);
      userStore.details.favouriteCount--;
    } else {
      feed.isFavourited = true;
      await FeedsApi.favourite(productId: feed.id, userId: userId);
      userStore.details.favouriteCount++;
    }
  }

  StreamSubscription<QuerySnapshot> subscribeToFeeds() {
    print('subscribeToFeeds start');
    
    try {
      _newsFeedSubscription =
        FeedsApi.listenForNewFeeds().listen(feedNewsListener);
        isFeedSubscribed = true;
    
    } catch (ex){
        isFeedSubscribed = false;
        print(ex);
    }
    return _newsFeedSubscription;
  }

  void unSubscribeToFeeds() {
    isFeedSubscribed = false;
    _newsFeedSubscription?.cancel();
  }

  void feedNewsListener(final QuerySnapshot querySnapshot) async {
    print('feedNewsListener called');
    print('_feedNewsListener ${querySnapshot.documents.length}');

    if (querySnapshot.documentChanges.isNotEmpty) {
      DocumentChange change = querySnapshot.documentChanges.elementAt(0);
      if (change.type == DocumentChangeType.modified ||
          change.type == DocumentChangeType.added) {
        print('Feeds added: ');
        if (_firstNotification) {
          _firstNotification = false;
          return;
        }
        showNewFeedsWidget();
        _firstNotification = true;
      }
    }


  }
}
