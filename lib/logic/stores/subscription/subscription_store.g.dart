// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubscriptionStore on _SubscriptionStore, Store {
  final _$statusAtom = Atom(name: '_SubscriptionStore.status');

  @override
  DataStatus get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(DataStatus value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$iPayCheckoutStatusAtom =
      Atom(name: '_SubscriptionStore.iPayCheckoutStatus');

  @override
  CheckoutStatus get iPayCheckoutStatus {
    _$iPayCheckoutStatusAtom.context
        .enforceReadPolicy(_$iPayCheckoutStatusAtom);
    _$iPayCheckoutStatusAtom.reportObserved();
    return super.iPayCheckoutStatus;
  }

  @override
  set iPayCheckoutStatus(CheckoutStatus value) {
    _$iPayCheckoutStatusAtom.context.conditionallyRunInAction(() {
      super.iPayCheckoutStatus = value;
      _$iPayCheckoutStatusAtom.reportChanged();
    }, _$iPayCheckoutStatusAtom, name: '${_$iPayCheckoutStatusAtom.name}_set');
  }

  final _$stripeCheckoutStatusAtom =
      Atom(name: '_SubscriptionStore.stripeCheckoutStatus');

  @override
  CheckoutStatus get stripeCheckoutStatus {
    _$stripeCheckoutStatusAtom.context
        .enforceReadPolicy(_$stripeCheckoutStatusAtom);
    _$stripeCheckoutStatusAtom.reportObserved();
    return super.stripeCheckoutStatus;
  }

  @override
  set stripeCheckoutStatus(CheckoutStatus value) {
    _$stripeCheckoutStatusAtom.context.conditionallyRunInAction(() {
      super.stripeCheckoutStatus = value;
      _$stripeCheckoutStatusAtom.reportChanged();
    }, _$stripeCheckoutStatusAtom,
        name: '${_$stripeCheckoutStatusAtom.name}_set');
  }

  final _$invoiceStateAtom = Atom(name: '_SubscriptionStore.invoiceState');

  @override
  InvoiceState get invoiceState {
    _$invoiceStateAtom.context.enforceReadPolicy(_$invoiceStateAtom);
    _$invoiceStateAtom.reportObserved();
    return super.invoiceState;
  }

  @override
  set invoiceState(InvoiceState value) {
    _$invoiceStateAtom.context.conditionallyRunInAction(() {
      super.invoiceState = value;
      _$invoiceStateAtom.reportChanged();
    }, _$invoiceStateAtom, name: '${_$invoiceStateAtom.name}_set');
  }

  final _$_SubscriptionStoreActionController =
      ActionController(name: '_SubscriptionStore');

  @override
  void setStripeCheckoutStatus(CheckoutStatus s) {
    final _$actionInfo = _$_SubscriptionStoreActionController.startAction();
    try {
      return super.setStripeCheckoutStatus(s);
    } finally {
      _$_SubscriptionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatus(DataStatus flag) {
    final _$actionInfo = _$_SubscriptionStoreActionController.startAction();
    try {
      return super.setStatus(flag);
    } finally {
      _$_SubscriptionStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIpayCheckoutStatus(CheckoutStatus status) {
    final _$actionInfo = _$_SubscriptionStoreActionController.startAction();
    try {
      return super.setIpayCheckoutStatus(status);
    } finally {
      _$_SubscriptionStoreActionController.endAction(_$actionInfo);
    }
  }
}
