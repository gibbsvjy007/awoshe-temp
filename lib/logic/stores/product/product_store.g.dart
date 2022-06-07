// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStore, Store {
  final _$productAtom = Atom(name: '_ProductStore.product');

  @override
  Product get product {
    _$productAtom.context.enforceReadPolicy(_$productAtom);
    _$productAtom.reportObserved();
    return super.product;
  }

  @override
  set product(Product value) {
    _$productAtom.context.conditionallyRunInAction(() {
      super.product = value;
      _$productAtom.reportChanged();
    }, _$productAtom, name: '${_$productAtom.name}_set');
  }

  final _$statusAtom = Atom(name: '_ProductStore.status');

  @override
  ProductStoreStatus get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(ProductStoreStatus value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$_ProductStoreActionController =
      ActionController(name: '_ProductStore');

  @override
  void setProduct(Product p) {
    final _$actionInfo = _$_ProductStoreActionController.startAction();
    try {
      return super.setProduct(p);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStoreStatus(ProductStoreStatus status) {
    final _$actionInfo = _$_ProductStoreActionController.startAction();
    try {
      return super.setStoreStatus(status);
    } finally {
      _$_ProductStoreActionController.endAction(_$actionInfo);
    }
  }
}
