// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryMenuStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryMenuStore on _CategoryMenuStore, Store {
  final _$categoryMapAtom = Atom(name: '_CategoryMenuStore.categoryMap');

  @override
  ObservableMap<String, List<String>> get categoryMap {
    _$categoryMapAtom.context.enforceReadPolicy(_$categoryMapAtom);
    _$categoryMapAtom.reportObserved();
    return super.categoryMap;
  }

  @override
  set categoryMap(ObservableMap<String, List<String>> value) {
    _$categoryMapAtom.context.conditionallyRunInAction(() {
      super.categoryMap = value;
      _$categoryMapAtom.reportChanged();
    }, _$categoryMapAtom, name: '${_$categoryMapAtom.name}_set');
  }

  final _$expandedCategoriesAtom =
      Atom(name: '_CategoryMenuStore.expandedCategories');

  @override
  ObservableList<String> get expandedCategories {
    _$expandedCategoriesAtom.context
        .enforceReadPolicy(_$expandedCategoriesAtom);
    _$expandedCategoriesAtom.reportObserved();
    return super.expandedCategories;
  }

  @override
  set expandedCategories(ObservableList<String> value) {
    _$expandedCategoriesAtom.context.conditionallyRunInAction(() {
      super.expandedCategories = value;
      _$expandedCategoriesAtom.reportChanged();
    }, _$expandedCategoriesAtom, name: '${_$expandedCategoriesAtom.name}_set');
  }

  final _$stateAtom = Atom(name: '_CategoryMenuStore.state');

  @override
  ClotheCategoryStoreState get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(ClotheCategoryStoreState value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$entryListAtom = Atom(name: '_CategoryMenuStore.entryList');

  @override
  ObservableList<Entry> get entryList {
    _$entryListAtom.context.enforceReadPolicy(_$entryListAtom);
    _$entryListAtom.reportObserved();
    return super.entryList;
  }

  @override
  set entryList(ObservableList<Entry> value) {
    _$entryListAtom.context.conditionallyRunInAction(() {
      super.entryList = value;
      _$entryListAtom.reportChanged();
    }, _$entryListAtom, name: '${_$entryListAtom.name}_set');
  }

  final _$_CategoryMenuStoreActionController =
      ActionController(name: '_CategoryMenuStore');

  @override
  void setEntryList(List<Entry> data) {
    final _$actionInfo = _$_CategoryMenuStoreActionController.startAction();
    try {
      return super.setEntryList(data);
    } finally {
      _$_CategoryMenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void expandCategory(String mainCategory) {
    final _$actionInfo = _$_CategoryMenuStoreActionController.startAction();
    try {
      return super.expandCategory(mainCategory);
    } finally {
      _$_CategoryMenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void collapseCategory(String mainCategory) {
    final _$actionInfo = _$_CategoryMenuStoreActionController.startAction();
    try {
      return super.collapseCategory(mainCategory);
    } finally {
      _$_CategoryMenuStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setState(ClotheCategoryStoreState state) {
    final _$actionInfo = _$_CategoryMenuStoreActionController.startAction();
    try {
      return super.setState(state);
    } finally {
      _$_CategoryMenuStoreActionController.endAction(_$actionInfo);
    }
  }
}
