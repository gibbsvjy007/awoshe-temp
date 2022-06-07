// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryStore on _CategoryStore, Store {
  final _$loadingAtom = Atom(name: '_CategoryStore.loading');

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

  final _$clotheCategoryAtom = Atom(name: '_CategoryStore.clotheCategory');

  @override
  ClotheCategory get clotheCategory {
    _$clotheCategoryAtom.context.enforceReadPolicy(_$clotheCategoryAtom);
    _$clotheCategoryAtom.reportObserved();
    return super.clotheCategory;
  }

  @override
  set clotheCategory(ClotheCategory value) {
    _$clotheCategoryAtom.context.conditionallyRunInAction(() {
      super.clotheCategory = value;
      _$clotheCategoryAtom.reportChanged();
    }, _$clotheCategoryAtom, name: '${_$clotheCategoryAtom.name}_set');
  }

  final _$mainCategoryAtom = Atom(name: '_CategoryStore.mainCategory');

  @override
  String get mainCategory {
    _$mainCategoryAtom.context.enforceReadPolicy(_$mainCategoryAtom);
    _$mainCategoryAtom.reportObserved();
    return super.mainCategory;
  }

  @override
  set mainCategory(String value) {
    _$mainCategoryAtom.context.conditionallyRunInAction(() {
      super.mainCategory = value;
      _$mainCategoryAtom.reportChanged();
    }, _$mainCategoryAtom, name: '${_$mainCategoryAtom.name}_set');
  }

  final _$productsAtom = Atom(name: '_CategoryStore.products');

  @override
  ObservableList<dynamic> get products {
    _$productsAtom.context.enforceReadPolicy(_$productsAtom);
    _$productsAtom.reportObserved();
    return super.products;
  }

  @override
  set products(ObservableList<dynamic> value) {
    _$productsAtom.context.conditionallyRunInAction(() {
      super.products = value;
      _$productsAtom.reportChanged();
    }, _$productsAtom, name: '${_$productsAtom.name}_set');
  }

  final _$fetchingProductsAtom = Atom(name: '_CategoryStore.fetchingProducts');

  @override
  bool get fetchingProducts {
    _$fetchingProductsAtom.context.enforceReadPolicy(_$fetchingProductsAtom);
    _$fetchingProductsAtom.reportObserved();
    return super.fetchingProducts;
  }

  @override
  set fetchingProducts(bool value) {
    _$fetchingProductsAtom.context.conditionallyRunInAction(() {
      super.fetchingProducts = value;
      _$fetchingProductsAtom.reportChanged();
    }, _$fetchingProductsAtom, name: '${_$fetchingProductsAtom.name}_set');
  }

  final _$allProductsFetchedAtom =
      Atom(name: '_CategoryStore.allProductsFetched');

  @override
  bool get allProductsFetched {
    _$allProductsFetchedAtom.context
        .enforceReadPolicy(_$allProductsFetchedAtom);
    _$allProductsFetchedAtom.reportObserved();
    return super.allProductsFetched;
  }

  @override
  set allProductsFetched(bool value) {
    _$allProductsFetchedAtom.context.conditionallyRunInAction(() {
      super.allProductsFetched = value;
      _$allProductsFetchedAtom.reportChanged();
    }, _$allProductsFetchedAtom, name: '${_$allProductsFetchedAtom.name}_set');
  }

  final _$getMainCategoryAsyncAction = AsyncAction('getMainCategory');

  @override
  Future<void> getMainCategory(String mainCategory) {
    return _$getMainCategoryAsyncAction
        .run(() => super.getMainCategory(mainCategory));
  }

  final _$fetchProductsByCategoryAsyncAction =
      AsyncAction('fetchProductsByCategory');

  @override
  Future<void> fetchProductsByCategory(
      {String mainCategory,
      String subCategory,
      String userId,
      bool fetchLatest = false}) {
    return _$fetchProductsByCategoryAsyncAction.run(() => super
        .fetchProductsByCategory(
            mainCategory: mainCategory,
            subCategory: subCategory,
            userId: userId,
            fetchLatest: fetchLatest));
  }

  final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore');

  @override
  void setClothCategory(ClotheCategory category) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setClothCategory(category);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMainCategory(String category) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setMainCategory(category);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool l) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setLoading(l);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFectching(bool l) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setFectching(l);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProducts(List<Feed> f, {bool reset = false}) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction();
    try {
      return super.setProducts(f, reset: reset);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }
}
