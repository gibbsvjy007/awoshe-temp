// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  final _$loadingAtom = Atom(name: '_MessageStore.loading');

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

  final _$allChatsFetchedAtom = Atom(name: '_MessageStore.allChatsFetched');

  @override
  bool get allChatsFetched {
    _$allChatsFetchedAtom.context.enforceReadPolicy(_$allChatsFetchedAtom);
    _$allChatsFetchedAtom.reportObserved();
    return super.allChatsFetched;
  }

  @override
  set allChatsFetched(bool value) {
    _$allChatsFetchedAtom.context.conditionallyRunInAction(() {
      super.allChatsFetched = value;
      _$allChatsFetchedAtom.reportChanged();
    }, _$allChatsFetchedAtom, name: '${_$allChatsFetchedAtom.name}_set');
  }

  final _$chatsAtom = Atom(name: '_MessageStore.chats');

  @override
  ObservableList<Chat> get chats {
    _$chatsAtom.context.enforceReadPolicy(_$chatsAtom);
    _$chatsAtom.reportObserved();
    return super.chats;
  }

  @override
  set chats(ObservableList<Chat> value) {
    _$chatsAtom.context.conditionallyRunInAction(() {
      super.chats = value;
      _$chatsAtom.reportChanged();
    }, _$chatsAtom, name: '${_$chatsAtom.name}_set');
  }

  final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore');

  @override
  void setLoading(bool l) {
    final _$actionInfo = _$_MessageStoreActionController.startAction();
    try {
      return super.setLoading(l);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChats(List<Chat> c) {
    final _$actionInfo = _$_MessageStoreActionController.startAction();
    try {
      return super.setChats(c);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilteredChats(List<Chat> c) {
    final _$actionInfo = _$_MessageStoreActionController.startAction();
    try {
      return super.setFilteredChats(c);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }
}
