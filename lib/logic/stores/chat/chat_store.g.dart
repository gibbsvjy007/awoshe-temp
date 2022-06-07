// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$chatIdAtom = Atom(name: '_ChatStore.chatId');

  @override
  String get chatId {
    _$chatIdAtom.context.enforceReadPolicy(_$chatIdAtom);
    _$chatIdAtom.reportObserved();
    return super.chatId;
  }

  @override
  set chatId(String value) {
    _$chatIdAtom.context.conditionallyRunInAction(() {
      super.chatId = value;
      _$chatIdAtom.reportChanged();
    }, _$chatIdAtom, name: '${_$chatIdAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_ChatStore.loading');

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

  final _$allMessagesFetchedAtom = Atom(name: '_ChatStore.allMessagesFetched');

  @override
  bool get allMessagesFetched {
    _$allMessagesFetchedAtom.context
        .enforceReadPolicy(_$allMessagesFetchedAtom);
    _$allMessagesFetchedAtom.reportObserved();
    return super.allMessagesFetched;
  }

  @override
  set allMessagesFetched(bool value) {
    _$allMessagesFetchedAtom.context.conditionallyRunInAction(() {
      super.allMessagesFetched = value;
      _$allMessagesFetchedAtom.reportChanged();
    }, _$allMessagesFetchedAtom, name: '${_$allMessagesFetchedAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_ChatStore.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$offersCacheAtom = Atom(name: '_ChatStore.offersCache');

  @override
  ObservableMap<String, Offer> get offersCache {
    _$offersCacheAtom.context.enforceReadPolicy(_$offersCacheAtom);
    _$offersCacheAtom.reportObserved();
    return super.offersCache;
  }

  @override
  set offersCache(ObservableMap<String, Offer> value) {
    _$offersCacheAtom.context.conditionallyRunInAction(() {
      super.offersCache = value;
      _$offersCacheAtom.reportChanged();
    }, _$offersCacheAtom, name: '${_$offersCacheAtom.name}_set');
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  dynamic addOffer(String offerId, Offer offer) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.addOffer(offerId, offer);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeOffer(String offerId) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.removeOffer(offerId);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool l) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.setLoading(l);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMessages(List<Message> l) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.setMessages(l);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }
}
