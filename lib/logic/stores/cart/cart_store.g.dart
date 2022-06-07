// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStore, Store {
  Computed<double> _$totalBillComputed;

  @override
  double get totalBill =>
      (_$totalBillComputed ??= Computed<double>(() => super.totalBill)).value;
  Computed<FutureStatus> _$getStatusComputed;

  @override
  FutureStatus get getStatus =>
      (_$getStatusComputed ??= Computed<FutureStatus>(() => super.getStatus))
          .value;
  Computed<bool> _$cartEmptyComputed;

  @override
  bool get cartEmpty =>
      (_$cartEmptyComputed ??= Computed<bool>(() => super.cartEmpty)).value;
  Computed<bool> _$hasResultsComputed;

  @override
  bool get hasResults =>
      (_$hasResultsComputed ??= Computed<bool>(() => super.hasResults)).value;

  final _$cartFutureAtom = Atom(name: '_CartStore.cartFuture');

  @override
  ObservableFuture<CartV2> get cartFuture {
    _$cartFutureAtom.context.enforceReadPolicy(_$cartFutureAtom);
    _$cartFutureAtom.reportObserved();
    return super.cartFuture;
  }

  @override
  set cartFuture(ObservableFuture<CartV2> value) {
    _$cartFutureAtom.context.conditionallyRunInAction(() {
      super.cartFuture = value;
      _$cartFutureAtom.reportChanged();
    }, _$cartFutureAtom, name: '${_$cartFutureAtom.name}_set');
  }

  final _$cartTotalAtom = Atom(name: '_CartStore.cartTotal');

  @override
  double get cartTotal {
    _$cartTotalAtom.context.enforceReadPolicy(_$cartTotalAtom);
    _$cartTotalAtom.reportObserved();
    return super.cartTotal;
  }

  @override
  set cartTotal(double value) {
    _$cartTotalAtom.context.conditionallyRunInAction(() {
      super.cartTotal = value;
      _$cartTotalAtom.reportChanged();
    }, _$cartTotalAtom, name: '${_$cartTotalAtom.name}_set');
  }

  final _$isEmptyAtom = Atom(name: '_CartStore.isEmpty');

  @override
  bool get isEmpty {
    _$isEmptyAtom.context.enforceReadPolicy(_$isEmptyAtom);
    _$isEmptyAtom.reportObserved();
    return super.isEmpty;
  }

  @override
  set isEmpty(bool value) {
    _$isEmptyAtom.context.conditionallyRunInAction(() {
      super.isEmpty = value;
      _$isEmptyAtom.reportChanged();
    }, _$isEmptyAtom, name: '${_$isEmptyAtom.name}_set');
  }

  final _$cartErrorAtom = Atom(name: '_CartStore.cartError');

  @override
  CartEvent get cartError {
    _$cartErrorAtom.context.enforceReadPolicy(_$cartErrorAtom);
    _$cartErrorAtom.reportObserved();
    return super.cartError;
  }

  @override
  set cartError(CartEvent value) {
    _$cartErrorAtom.context.conditionallyRunInAction(() {
      super.cartError = value;
      _$cartErrorAtom.reportChanged();
    }, _$cartErrorAtom, name: '${_$cartErrorAtom.name}_set');
  }

  final _$getCartAsyncAction = AsyncAction('getCart');

  @override
  Future<CartV2> getCart(String userId) {
    return _$getCartAsyncAction.run(() => super.getCart(userId));
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  dynamic setCartEvent(CartEvent data) {
    final _$actionInfo = _$_CartStoreActionController.startAction();
    try {
      return super.setCartEvent(data);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmpty(bool flag) {
    final _$actionInfo = _$_CartStoreActionController.startAction();
    try {
      return super.setEmpty(flag);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCartTotal() {
    final _$actionInfo = _$_CartStoreActionController.startAction();
    try {
      return super.setCartTotal();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }
}
