// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OcassionStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OcassionStore on _OcassionStore, Store {
  final _$storeStateAtom = Atom(name: '_OcassionStore.storeState');

  @override
  OcassionStoreState get storeState {
    _$storeStateAtom.context.enforceReadPolicy(_$storeStateAtom);
    _$storeStateAtom.reportObserved();
    return super.storeState;
  }

  @override
  set storeState(OcassionStoreState value) {
    _$storeStateAtom.context.conditionallyRunInAction(() {
      super.storeState = value;
      _$storeStateAtom.reportChanged();
    }, _$storeStateAtom, name: '${_$storeStateAtom.name}_set');
  }

  final _$isLoadingMoreAtom = Atom(name: '_OcassionStore.isLoadingMore');

  @override
  bool get isLoadingMore {
    _$isLoadingMoreAtom.context.enforceReadPolicy(_$isLoadingMoreAtom);
    _$isLoadingMoreAtom.reportObserved();
    return super.isLoadingMore;
  }

  @override
  set isLoadingMore(bool value) {
    _$isLoadingMoreAtom.context.conditionallyRunInAction(() {
      super.isLoadingMore = value;
      _$isLoadingMoreAtom.reportChanged();
    }, _$isLoadingMoreAtom, name: '${_$isLoadingMoreAtom.name}_set');
  }

  final _$_OcassionStoreActionController =
      ActionController(name: '_OcassionStore');

  @override
  void _setStoreState(OcassionStoreState state) {
    final _$actionInfo = _$_OcassionStoreActionController.startAction();
    try {
      return super._setStoreState(state);
    } finally {
      _$_OcassionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setLoadingMore(bool flag) {
    final _$actionInfo = _$_OcassionStoreActionController.startAction();
    try {
      return super._setLoadingMore(flag);
    } finally {
      _$_OcassionStoreActionController.endAction(_$actionInfo);
    }
  }
}
