// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordering_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrderingStore on _OrderingStore, Store {
  final _$orderAtom = Atom(name: '_OrderingStore.order');

  @override
  Order get order {
    _$orderAtom.context.enforceReadPolicy(_$orderAtom);
    _$orderAtom.reportObserved();
    return super.order;
  }

  @override
  set order(Order value) {
    _$orderAtom.context.conditionallyRunInAction(() {
      super.order = value;
      _$orderAtom.reportChanged();
    }, _$orderAtom, name: '${_$orderAtom.name}_set');
  }

  final _$checkoutStatusAtom = Atom(name: '_OrderingStore.checkoutStatus');

  @override
  CheckoutStatus get checkoutStatus {
    _$checkoutStatusAtom.context.enforceReadPolicy(_$checkoutStatusAtom);
    _$checkoutStatusAtom.reportObserved();
    return super.checkoutStatus;
  }

  @override
  set checkoutStatus(CheckoutStatus value) {
    _$checkoutStatusAtom.context.conditionallyRunInAction(() {
      super.checkoutStatus = value;
      _$checkoutStatusAtom.reportChanged();
    }, _$checkoutStatusAtom, name: '${_$checkoutStatusAtom.name}_set');
  }

  final _$checkoutErrorMsgAtom = Atom(name: '_OrderingStore.checkoutErrorMsg');

  @override
  String get checkoutErrorMsg {
    _$checkoutErrorMsgAtom.context.enforceReadPolicy(_$checkoutErrorMsgAtom);
    _$checkoutErrorMsgAtom.reportObserved();
    return super.checkoutErrorMsg;
  }

  @override
  set checkoutErrorMsg(String value) {
    _$checkoutErrorMsgAtom.context.conditionallyRunInAction(() {
      super.checkoutErrorMsg = value;
      _$checkoutErrorMsgAtom.reportChanged();
    }, _$checkoutErrorMsgAtom, name: '${_$checkoutErrorMsgAtom.name}_set');
  }

  final _$paymentTypeAtom = Atom(name: '_OrderingStore.paymentType');

  @override
  PaymentMethod get paymentType {
    _$paymentTypeAtom.context.enforceReadPolicy(_$paymentTypeAtom);
    _$paymentTypeAtom.reportObserved();
    return super.paymentType;
  }

  @override
  set paymentType(PaymentMethod value) {
    _$paymentTypeAtom.context.conditionallyRunInAction(() {
      super.paymentType = value;
      _$paymentTypeAtom.reportChanged();
    }, _$paymentTypeAtom, name: '${_$paymentTypeAtom.name}_set');
  }

  final _$_OrderingStoreActionController =
      ActionController(name: '_OrderingStore');

  @override
  void setPaymentMethod(PaymentMethod type) {
    final _$actionInfo = _$_OrderingStoreActionController.startAction();
    try {
      return super.setPaymentMethod(type);
    } finally {
      _$_OrderingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShippingAddress(Address addr) {
    final _$actionInfo = _$_OrderingStoreActionController.startAction();
    try {
      return super.setShippingAddress(addr);
    } finally {
      _$_OrderingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBillingAddress(Address addr) {
    final _$actionInfo = _$_OrderingStoreActionController.startAction();
    try {
      return super.setBillingAddress(addr);
    } finally {
      _$_OrderingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckoutStatus(CheckoutStatus status) {
    final _$actionInfo = _$_OrderingStoreActionController.startAction();
    try {
      return super.setCheckoutStatus(status);
    } finally {
      _$_OrderingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckoutErrorMsg(String msg) {
    final _$actionInfo = _$_OrderingStoreActionController.startAction();
    try {
      return super.setCheckoutErrorMsg(msg);
    } finally {
      _$_OrderingStoreActionController.endAction(_$actionInfo);
    }
  }
}
