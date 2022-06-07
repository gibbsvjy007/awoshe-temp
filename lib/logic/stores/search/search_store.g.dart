// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  Computed<SearchType> _$currentSearchTypeComputed;

  @override
  SearchType get currentSearchType => (_$currentSearchTypeComputed ??=
          Computed<SearchType>(() => super.currentSearchType))
      .value;

  final _$loadingAtom = Atom(name: '_SearchStore.loading');

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

  final _$searchFinishedAtom = Atom(name: '_SearchStore.searchFinished');

  @override
  bool get searchFinished {
    _$searchFinishedAtom.context.enforceReadPolicy(_$searchFinishedAtom);
    _$searchFinishedAtom.reportObserved();
    return super.searchFinished;
  }

  @override
  set searchFinished(bool value) {
    _$searchFinishedAtom.context.conditionallyRunInAction(() {
      super.searchFinished = value;
      _$searchFinishedAtom.reportChanged();
    }, _$searchFinishedAtom, name: '${_$searchFinishedAtom.name}_set');
  }

  final _$searchResultsAtom = Atom(name: '_SearchStore.searchResults');

  @override
  ObservableList<SearchResultItem> get searchResults {
    _$searchResultsAtom.context.enforceReadPolicy(_$searchResultsAtom);
    _$searchResultsAtom.reportObserved();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<SearchResultItem> value) {
    _$searchResultsAtom.context.conditionallyRunInAction(() {
      super.searchResults = value;
      _$searchResultsAtom.reportChanged();
    }, _$searchResultsAtom, name: '${_$searchResultsAtom.name}_set');
  }

  final _$currentTypeAtom = Atom(name: '_SearchStore.currentType');

  @override
  SearchType get currentType {
    _$currentTypeAtom.context.enforceReadPolicy(_$currentTypeAtom);
    _$currentTypeAtom.reportObserved();
    return super.currentType;
  }

  @override
  set currentType(SearchType value) {
    _$currentTypeAtom.context.conditionallyRunInAction(() {
      super.currentType = value;
      _$currentTypeAtom.reportChanged();
    }, _$currentTypeAtom, name: '${_$currentTypeAtom.name}_set');
  }

  final _$initUserSearchAsyncAction = AsyncAction('initUserSearch');

  @override
  Future<void> initUserSearch() {
    return _$initUserSearchAsyncAction.run(() => super.initUserSearch());
  }

  final _$setSearchTypeAsyncAction = AsyncAction('setSearchType');

  @override
  Future<void> setSearchType(SearchType type) {
    return _$setSearchTypeAsyncAction.run(() => super.setSearchType(type));
  }

  final _$startSearchingAsyncAction = AsyncAction('startSearching');

  @override
  Future<void> startSearching({String query}) {
    return _$startSearchingAsyncAction
        .run(() => super.startSearching(query: query));
  }
}
