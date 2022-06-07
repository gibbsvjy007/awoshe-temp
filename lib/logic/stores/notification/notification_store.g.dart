// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationStore on _NotificationStore, Store {
  final _$allDataFetchedAtom = Atom(name: '_NotificationStore.allDataFetched');

  @override
  bool get allDataFetched {
    _$allDataFetchedAtom.context.enforceReadPolicy(_$allDataFetchedAtom);
    _$allDataFetchedAtom.reportObserved();
    return super.allDataFetched;
  }

  @override
  set allDataFetched(bool value) {
    _$allDataFetchedAtom.context.conditionallyRunInAction(() {
      super.allDataFetched = value;
      _$allDataFetchedAtom.reportChanged();
    }, _$allDataFetchedAtom, name: '${_$allDataFetchedAtom.name}_set');
  }

  final _$loadingAtom = Atom(name: '_NotificationStore.loading');

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

  final _$notificationListAtom =
      Atom(name: '_NotificationStore.notificationList');

  @override
  ObservableList<Notifications> get notificationList {
    _$notificationListAtom.context.enforceReadPolicy(_$notificationListAtom);
    _$notificationListAtom.reportObserved();
    return super.notificationList;
  }

  @override
  set notificationList(ObservableList<Notifications> value) {
    _$notificationListAtom.context.conditionallyRunInAction(() {
      super.notificationList = value;
      _$notificationListAtom.reportChanged();
    }, _$notificationListAtom, name: '${_$notificationListAtom.name}_set');
  }

  final _$todayNotificationListAtom =
      Atom(name: '_NotificationStore.todayNotificationList');

  @override
  ObservableList<Notifications> get todayNotificationList {
    _$todayNotificationListAtom.context
        .enforceReadPolicy(_$todayNotificationListAtom);
    _$todayNotificationListAtom.reportObserved();
    return super.todayNotificationList;
  }

  @override
  set todayNotificationList(ObservableList<Notifications> value) {
    _$todayNotificationListAtom.context.conditionallyRunInAction(() {
      super.todayNotificationList = value;
      _$todayNotificationListAtom.reportChanged();
    }, _$todayNotificationListAtom,
        name: '${_$todayNotificationListAtom.name}_set');
  }

  final _$earlierNotificationListAtom =
      Atom(name: '_NotificationStore.earlierNotificationList');

  @override
  ObservableList<Notifications> get earlierNotificationList {
    _$earlierNotificationListAtom.context
        .enforceReadPolicy(_$earlierNotificationListAtom);
    _$earlierNotificationListAtom.reportObserved();
    return super.earlierNotificationList;
  }

  @override
  set earlierNotificationList(ObservableList<Notifications> value) {
    _$earlierNotificationListAtom.context.conditionallyRunInAction(() {
      super.earlierNotificationList = value;
      _$earlierNotificationListAtom.reportChanged();
    }, _$earlierNotificationListAtom,
        name: '${_$earlierNotificationListAtom.name}_set');
  }

  final _$frAcceptedListAtom = Atom(name: '_NotificationStore.frAcceptedList');

  @override
  ObservableList<String> get frAcceptedList {
    _$frAcceptedListAtom.context.enforceReadPolicy(_$frAcceptedListAtom);
    _$frAcceptedListAtom.reportObserved();
    return super.frAcceptedList;
  }

  @override
  set frAcceptedList(ObservableList<String> value) {
    _$frAcceptedListAtom.context.conditionallyRunInAction(() {
      super.frAcceptedList = value;
      _$frAcceptedListAtom.reportChanged();
    }, _$frAcceptedListAtom, name: '${_$frAcceptedListAtom.name}_set');
  }

  final _$frRejectedListAtom = Atom(name: '_NotificationStore.frRejectedList');

  @override
  ObservableList<String> get frRejectedList {
    _$frRejectedListAtom.context.enforceReadPolicy(_$frRejectedListAtom);
    _$frRejectedListAtom.reportObserved();
    return super.frRejectedList;
  }

  @override
  set frRejectedList(ObservableList<String> value) {
    _$frRejectedListAtom.context.conditionallyRunInAction(() {
      super.frRejectedList = value;
      _$frRejectedListAtom.reportChanged();
    }, _$frRejectedListAtom, name: '${_$frRejectedListAtom.name}_set');
  }

  final _$eventInviteAcceptListAtom =
      Atom(name: '_NotificationStore.eventInviteAcceptList');

  @override
  ObservableList<String> get eventInviteAcceptList {
    _$eventInviteAcceptListAtom.context
        .enforceReadPolicy(_$eventInviteAcceptListAtom);
    _$eventInviteAcceptListAtom.reportObserved();
    return super.eventInviteAcceptList;
  }

  @override
  set eventInviteAcceptList(ObservableList<String> value) {
    _$eventInviteAcceptListAtom.context.conditionallyRunInAction(() {
      super.eventInviteAcceptList = value;
      _$eventInviteAcceptListAtom.reportChanged();
    }, _$eventInviteAcceptListAtom,
        name: '${_$eventInviteAcceptListAtom.name}_set');
  }

  final _$eventInviteRejectListAtom =
      Atom(name: '_NotificationStore.eventInviteRejectList');

  @override
  ObservableList<String> get eventInviteRejectList {
    _$eventInviteRejectListAtom.context
        .enforceReadPolicy(_$eventInviteRejectListAtom);
    _$eventInviteRejectListAtom.reportObserved();
    return super.eventInviteRejectList;
  }

  @override
  set eventInviteRejectList(ObservableList<String> value) {
    _$eventInviteRejectListAtom.context.conditionallyRunInAction(() {
      super.eventInviteRejectList = value;
      _$eventInviteRejectListAtom.reportChanged();
    }, _$eventInviteRejectListAtom,
        name: '${_$eventInviteRejectListAtom.name}_set');
  }

  final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore');

  @override
  void addAcceptedFR(String id) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.addAcceptedFR(id);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addRejectedFR(String id) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.addRejectedFR(id);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEventInviteAcceptedRequest(String id) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.addEventInviteAcceptedRequest(id);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEventInviteRejectRequest(String id) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.addEventInviteRejectRequest(id);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotification(List<Notifications> p) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction();
    try {
      return super.setNotification(p);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }
}
