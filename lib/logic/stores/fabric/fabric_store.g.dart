// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fabric_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FabricStore on _FabricStore, Store {
  final _$isLoadingAtom = Atom(name: '_FabricStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$allFabricsFetchedAtom = Atom(name: '_FabricStore.allFabricsFetched');

  @override
  bool get allFabricsFetched {
    _$allFabricsFetchedAtom.context.enforceReadPolicy(_$allFabricsFetchedAtom);
    _$allFabricsFetchedAtom.reportObserved();
    return super.allFabricsFetched;
  }

  @override
  set allFabricsFetched(bool value) {
    _$allFabricsFetchedAtom.context.conditionallyRunInAction(() {
      super.allFabricsFetched = value;
      _$allFabricsFetchedAtom.reportChanged();
    }, _$allFabricsFetchedAtom, name: '${_$allFabricsFetchedAtom.name}_set');
  }

  final _$fabricsAtom = Atom(name: '_FabricStore.fabrics');

  @override
  ObservableList<Product> get fabrics {
    _$fabricsAtom.context.enforceReadPolicy(_$fabricsAtom);
    _$fabricsAtom.reportObserved();
    return super.fabrics;
  }

  @override
  set fabrics(ObservableList<Product> value) {
    _$fabricsAtom.context.conditionallyRunInAction(() {
      super.fabrics = value;
      _$fabricsAtom.reportChanged();
    }, _$fabricsAtom, name: '${_$fabricsAtom.name}_set');
  }

  final _$_FabricStoreActionController = ActionController(name: '_FabricStore');

  @override
  void setLoading(bool isLoading) {
    final _$actionInfo = _$_FabricStoreActionController.startAction();
    try {
      return super.setLoading(isLoading);
    } finally {
      _$_FabricStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFabrics(List<Product> fabrics, {bool reset = false}) {
    final _$actionInfo = _$_FabricStoreActionController.startAction();
    try {
      return super.setFabrics(fabrics, reset: reset);
    } finally {
      _$_FabricStoreActionController.endAction(_$actionInfo);
    }
  }
}
