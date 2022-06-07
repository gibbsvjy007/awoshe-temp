import 'package:Awoshe/logic/stores/cache/cache_stores/UserDetailsCacheStore.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  AuthenticationService authService = AuthenticationService.instance;
  final UserStore _userStore;

  _AuthStore({@required UserStore userStore}) : _userStore = userStore;

  @observable
  bool authenticated = false;

  @observable
  bool authenticatingWithFacebook = false;

  @observable
  bool authenticatingWithGoogle = false;

  @observable
  bool authenticating = false;

  @observable
  bool hasInternet = true;

  @action
  setInternetPresence(bool flag) => hasInternet = flag;

  @action
  setAuthenticatingWithFacebook(bool isAuthenticating) {
    authenticatingWithFacebook = isAuthenticating;
  }

  @action
  setAuthenticatingWithGoogle(bool isAuthenticating) {
    authenticatingWithGoogle = isAuthenticating;
  }

  @action
  setAuthenticating(bool isAuthenticating) {
    authenticating = isAuthenticating;
  }

  @action
  authenticateUser() {
    authenticated = true;
  }

  Future<void> loginWithFaceBook() async {
    setAuthenticatingWithFacebook(true);

    try {
      final UserDetails userDetails = await authService.signInWithFacebook();

      _userStore.setUserDetails(userDetails);
      UserDetailsCacheStore.instance.setData(userDetails);
      authenticateUser();
      this.setInternetPresence(true);
    } catch (e) {
      print(e.code);
    }

    setAuthenticatingWithFacebook(false);
  }

  Future<void> loginWithGoogle() async {
    setAuthenticatingWithGoogle(true);

    try {
      final UserDetails userDetails = await authService.signInWithGoogle();
      _userStore.setUserDetails(userDetails);
      UserDetailsCacheStore.instance.setData(userDetails);
      authenticateUser();
      this.setInternetPresence(true);
    } catch (e) {
      print(e.code);
    }

    setAuthenticatingWithGoogle(false);

  }

  Future<void> signInAnonymously() async {
    setAuthenticating(true);
    try {
      final UserDetails userDetails = await authService.signInAnonymously();
      _userStore.setUserDetails(userDetails);
      UserDetailsCacheStore.instance.setData(userDetails);
      authenticateUser();
      this.setInternetPresence(true);
    } catch (e) {
      print(e);
      setAuthenticating(false);
      throw e;
    }

    setAuthenticating(false);

  }

  Future<void> loginWithAccount({String email, String password}) async {
    setAuthenticating(true);
    try {
      var fbUser = await authService.signInWithAccount(email, password);
      
      final UserDetails details = await authService.fetchUserDetail(fbUser.uid);
      _userStore.setUserDetails(details);
      UserDetailsCacheStore.instance.setData(details);
      authenticateUser();
      this.setInternetPresence(true);
    }

    on PlatformException catch (ex) {
      print(ex.code);
      throw ex;
    }

    setAuthenticating(false);
  }
}
