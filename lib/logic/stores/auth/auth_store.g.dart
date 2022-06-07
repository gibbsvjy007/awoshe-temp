// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$authenticatedAtom = Atom(name: '_AuthStore.authenticated');

  @override
  bool get authenticated {
    _$authenticatedAtom.context.enforceReadPolicy(_$authenticatedAtom);
    _$authenticatedAtom.reportObserved();
    return super.authenticated;
  }

  @override
  set authenticated(bool value) {
    _$authenticatedAtom.context.conditionallyRunInAction(() {
      super.authenticated = value;
      _$authenticatedAtom.reportChanged();
    }, _$authenticatedAtom, name: '${_$authenticatedAtom.name}_set');
  }

  final _$authenticatingWithFacebookAtom =
      Atom(name: '_AuthStore.authenticatingWithFacebook');

  @override
  bool get authenticatingWithFacebook {
    _$authenticatingWithFacebookAtom.context
        .enforceReadPolicy(_$authenticatingWithFacebookAtom);
    _$authenticatingWithFacebookAtom.reportObserved();
    return super.authenticatingWithFacebook;
  }

  @override
  set authenticatingWithFacebook(bool value) {
    _$authenticatingWithFacebookAtom.context.conditionallyRunInAction(() {
      super.authenticatingWithFacebook = value;
      _$authenticatingWithFacebookAtom.reportChanged();
    }, _$authenticatingWithFacebookAtom,
        name: '${_$authenticatingWithFacebookAtom.name}_set');
  }

  final _$authenticatingWithGoogleAtom =
      Atom(name: '_AuthStore.authenticatingWithGoogle');

  @override
  bool get authenticatingWithGoogle {
    _$authenticatingWithGoogleAtom.context
        .enforceReadPolicy(_$authenticatingWithGoogleAtom);
    _$authenticatingWithGoogleAtom.reportObserved();
    return super.authenticatingWithGoogle;
  }

  @override
  set authenticatingWithGoogle(bool value) {
    _$authenticatingWithGoogleAtom.context.conditionallyRunInAction(() {
      super.authenticatingWithGoogle = value;
      _$authenticatingWithGoogleAtom.reportChanged();
    }, _$authenticatingWithGoogleAtom,
        name: '${_$authenticatingWithGoogleAtom.name}_set');
  }

  final _$authenticatingAtom = Atom(name: '_AuthStore.authenticating');

  @override
  bool get authenticating {
    _$authenticatingAtom.context.enforceReadPolicy(_$authenticatingAtom);
    _$authenticatingAtom.reportObserved();
    return super.authenticating;
  }

  @override
  set authenticating(bool value) {
    _$authenticatingAtom.context.conditionallyRunInAction(() {
      super.authenticating = value;
      _$authenticatingAtom.reportChanged();
    }, _$authenticatingAtom, name: '${_$authenticatingAtom.name}_set');
  }

  final _$hasInternetAtom = Atom(name: '_AuthStore.hasInternet');

  @override
  bool get hasInternet {
    _$hasInternetAtom.context.enforceReadPolicy(_$hasInternetAtom);
    _$hasInternetAtom.reportObserved();
    return super.hasInternet;
  }

  @override
  set hasInternet(bool value) {
    _$hasInternetAtom.context.conditionallyRunInAction(() {
      super.hasInternet = value;
      _$hasInternetAtom.reportChanged();
    }, _$hasInternetAtom, name: '${_$hasInternetAtom.name}_set');
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  dynamic setInternetPresence(bool flag) {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.setInternetPresence(flag);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthenticatingWithFacebook(bool isAuthenticating) {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.setAuthenticatingWithFacebook(isAuthenticating);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthenticatingWithGoogle(bool isAuthenticating) {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.setAuthenticatingWithGoogle(isAuthenticating);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthenticating(bool isAuthenticating) {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.setAuthenticating(isAuthenticating);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic authenticateUser() {
    final _$actionInfo = _$_AuthStoreActionController.startAction();
    try {
      return super.authenticateUser();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }
}
