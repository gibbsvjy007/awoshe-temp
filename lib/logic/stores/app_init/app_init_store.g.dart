// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_init_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppInitStore on _AppInitStore, Store {
  final _$hasInternetPresenceAtom =
      Atom(name: '_AppInitStore.hasInternetPresence');

  @override
  bool get hasInternetPresence {
    _$hasInternetPresenceAtom.context
        .enforceReadPolicy(_$hasInternetPresenceAtom);
    _$hasInternetPresenceAtom.reportObserved();
    return super.hasInternetPresence;
  }

  @override
  set hasInternetPresence(bool value) {
    _$hasInternetPresenceAtom.context.conditionallyRunInAction(() {
      super.hasInternetPresence = value;
      _$hasInternetPresenceAtom.reportChanged();
    }, _$hasInternetPresenceAtom,
        name: '${_$hasInternetPresenceAtom.name}_set');
  }

  final _$_AppInitStoreActionController =
      ActionController(name: '_AppInitStore');

  @override
  void setInternetPresence(bool flag) {
    final _$actionInfo = _$_AppInitStoreActionController.startAction();
    try {
      return super.setInternetPresence(flag);
    } finally {
      _$_AppInitStoreActionController.endAction(_$actionInfo);
    }
  }
}
