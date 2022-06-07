import 'dart:async';
import 'dart:io';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/api/auth_api.dart';
import 'package:Awoshe/logic/api/user_api.dart';
import 'package:Awoshe/models/exception/AppInitException.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/pages/app_init.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

abstract class AuthenticationService {
  static final AuthenticationService instance = _AuthenticationServiceImpl(
      FirebaseAuth.instance, InitializationPage.awosheAnalytics);

  Future<UserDetails> signInWithGoogle();

  Future<UserDetails> signInWithFacebook();

  Future<UserDetails> signInAnonymously();

  Future<UserDetails> setAnonymousUser(FirebaseUser user);

  Future<FirebaseUser> signInWithAccount(String email, String password);

  Future<FirebaseUser> signUpWithAccount(
      String email, String password, String name, String handle);

  Future<void> sendResetPasswordEmail(String email);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();

  Future<bool> analyticsEnabled();

  Future<void> setAnalyticsEnabled(bool enabled);

  Future<bool> isLoggedIn();

  Future<void> setLoggedIn(bool isLoggedIn);

  Future<void> setUserId(String userId);

  Future<String> getUserId();

  Future<UserDetails> fetchUserDetail(String userId);

  static String appUserId = "";
  static String userFullName = "";
}

class AuthCancelledException implements Exception {
  final String message;

  AuthCancelledException(this.message);

  @override
  String toString() => message;
}

const String _ANALYTICS_ENABLED_KEY = "analyticsEnabled";
const USER_ID = "UserId";
const USER_FULL_NAME = "fullName";
const String _IS_LOGGED_IN = "isLoggedIn";

class _AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseAnalytics _analytics;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final facebookLogin = FacebookLogin();

  _AuthenticationServiceImpl(this._firebaseAuth, this._analytics);

  @override
  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser().timeout(const Duration(seconds: 5),
        onTimeout: () => Future.error(Exception(
            "Unable to get your user data. Please check your network connection.")));
  }

  Future<UserDetails> fetchUserDetail(String userId) async {
    print('____________fetchUserDetail ' + userId);
    UserDetails userDetails =
        await UserApi.getUserProfile(loggerInUser: userId);
    return userDetails;
  }

  Future<UserDetails> setAnonymousUser(FirebaseUser user) async {
    UserDetails userDetails = UserDetails(
        name: 'Anonymous',
        thumbnailUrl: 'https://ui-avatars.com/api/?name=N+A&background=EA8439&color=fff',
        id: user.uid,
        email: 'anonymous@anonymous.com',
        pictureUrl: 'https://ui-avatars.com/api/?name=N+A&background=EA8439&color=fff',
        handle: 'anonymous',
        isDesigner: false,
      isAnonymous: true,
      currency: DEFAULT_CURRENCY, // default currency USD.
    );
    return userDetails;
  }

  @override
  Future<UserDetails> signInAnonymously() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInAnonymously().timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw AppInitException(
            type: AppInitError.NO_INTERNET,
            message: "Unable to sign in. Please check your network connection."
          ), 
          );
      final FirebaseUser user = authResult.user;
      print(user);
      if (user == null) {
        throw Exception("Unable to sign-in");
      }
      UserDetails userDetails = await setAnonymousUser(user);
      return userDetails;
    } 
    
    on PlatformException catch (e) {
      if (e.details != null && e.details is String) {
        throw Exception(e.details);
      }
      throw e;
    }

    on AppInitException catch(ex) {
      throw ex;
    }
  }

  @override
  Future<FirebaseUser> signInWithAccount(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.getCredential(email: email, password: password);

      final AuthResult authResult = await _firebaseAuth
          .signInWithCredential(credential)
          .timeout(const Duration(seconds: 5),
              onTimeout: () => Future.error(Exception(
                  "Unable to sign in. Please check your network connection.")));

      final FirebaseUser user = authResult.user;
      print(user);
      if (user == null) {
        throw Exception("Unable to sign-in");
      }

      ///lets put the user name as displayName inside the users and profile. fullName also has to be set
      assert(user.email != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      print("_______SET USER ROLE HAHA__________");
//      await Utils.setDesigner(user.uid);
//      AuthenticationService.userFullName = await Utils.getUserFullName(user.uid);
//      AuthenticationService.instance.setUserFullName(AuthenticationService.userFullName);
      _analytics.setUserId(user.uid);
      this.setUserId(user.uid);
      return user;
    } on PlatformException catch (e) {
      if (e.details != null && e.details is String) {
        throw e; //Exception(e.details);
      }
      throw e;
    }
  }

  @override
  Future<UserDetails> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    UserDetails userDetails;
    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    if (googleUser == null) {
      throw AuthCancelledException("User cancelled");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(credential)
        .timeout(const Duration(seconds: 5),
            onTimeout: () => Future.error(Exception(
                "Unable to sign in. Please check your network connection.")));
    final FirebaseUser user = authResult.user;

    if (user == null) {
      throw Exception("Unable to sign-in with Google");
    }
    assert(user.uid != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    _analytics.setUserId(user.uid);
    this.setUserId(user.uid);
    print("google signin___________");
    print(user.toString());
    print(user.providerData[0].email);

    final FirebaseMessaging _messaging = FirebaseMessaging();
    String deviceToken = await _messaging.getToken();
    String platform =
        Platform.isAndroid ? PLATFORM['android'] : PLATFORM['ios'];

    final UserInfo providerData = authResult.user.providerData[0];


    userDetails = await getUserDetails(
        name: providerData.displayName,
        thumbnailUrl: user.photoUrl,
        handle: providerData.email.split('@')[0],
        pictureUrl: user.photoUrl,
        email: providerData.email,
        id: user.uid,
        platform: platform,
        token: deviceToken
    );

    return userDetails;
  }

  @override
  Future<UserDetails> signInWithFacebook() async {
    FacebookLoginResult result = await facebookLogin.logIn(['email']);
    UserDetails userDetails;
    // ignore: missing_enum_constant_in_switch
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        throw AuthCancelledException("User cancelled");
      case FacebookLoginStatus.error:
        throw Exception("Error occurred: ${result.errorMessage}");
    }

    if (result.status != FacebookLoginStatus.loggedIn) {
      throw Exception("Unknown status: ${result.status}");
    }

    final token = result.accessToken.token;
    final AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token);
    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(credential)
        .timeout(const Duration(seconds: 5),
            onTimeout: () => Future.error(Exception(
                "Unable to sign in. Please check your network connection.")));
    final FirebaseUser user = authResult.user;

    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    _analytics.setUserId(user.uid);
    this.setUserId(user.uid);
    print("facebook  signin___________");
    //print(user.toString());
    //print(user.providerData[0].email);

    if (user.providerData.length > 0) {
      UserInfo prodiverData =
          user.providerData.firstWhere((dt) => dt.providerId == "facebook.com");
      print(prodiverData.toString());
      print(prodiverData.email);

      final graphResponse = await http.get(
          'https://graph.facebook.com/v5.0/me?fields=name,first_name,last_name,email,picture.type(large)&access_token=$token');
      final profile = convert.jsonDecode(graphResponse.body);
      final FirebaseMessaging _messaging = FirebaseMessaging();
      String deviceToken = await _messaging.getToken();
      String platform =
          Platform.isAndroid ? PLATFORM['android'] : PLATFORM['ios'];

        userDetails = await getUserDetails(
          id:user.uid,
          email: profile['email'],
          isAnonymous: false,
          name: profile['name'],
          token: deviceToken,
          platform: platform,
          handle: profile['email'].split('@')[0],
          pictureUrl: profile['picture']['data']['url'],
          thumbnailUrl: profile['picture']['data']['url']
        );

      _analytics.setUserId(user.uid);
    }

    return userDetails;
  }

  @override
  Future<FirebaseUser> signUpWithAccount(
      String email, String password, String name, String handle) async {

    try {
      final AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 5),
              onTimeout: () => Future.error(Exception(
                  "Unable to sign up. Please check your network connection.")));
      final FirebaseUser user = authResult.user;

      if (user == null) {
        throw Exception("Unable to sign-up");
      }

      assert(user.email != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseMessaging _messaging = FirebaseMessaging();
      String deviceToken = await _messaging.getToken();

      String platform =
          Platform.isAndroid ? PLATFORM['android'] : PLATFORM['ios'];

      AuthApi.registerUser(
          name: name,
          email: email,
          handle: handle,
          uid: user.uid,
          platform: platform,
          deviceToken: deviceToken);
      _analytics.setUserId(user.uid);
      this.setUserId(user.uid);

      return user;
    } on PlatformException catch (e) {
      if (e.details != null && e.details is String) {
        throw Exception(e.details);
      }

      throw e;
    }
  }

  @override
  signOut() async {
    await _googleSignIn.signOut();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserId(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, uid);
  }

  @override
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID);
  }

  @override
  Future<void> sendResetPasswordEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email).timeout(
        const Duration(seconds: 5),
        onTimeout: () => Future.error(Exception(
            "Unable to send reset password request. Please check your network connection.")));
  }

  @override
  Future<bool> analyticsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getKeys().contains(_ANALYTICS_ENABLED_KEY)) {
      return true;
    }

    return prefs.getBool(_ANALYTICS_ENABLED_KEY);
  }

  @override
  Future<void> setAnalyticsEnabled(bool enabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_ANALYTICS_ENABLED_KEY, enabled);
  }

  @override
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_IS_LOGGED_IN, isLoggedIn);
  }

  @override
  isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getKeys().contains(_IS_LOGGED_IN)) {
      return false;
    }
    return prefs.getBool(_IS_LOGGED_IN);
  }

  Future<UserDetails> getUserDetails({
  String id, String email, bool isAnonymous, String platform,
  String name, String handle, String pictureUrl, String token,
    String thumbnailUrl,}) async {

    UserDetails data;
    try {
       data = await fetchUserDetail(id);

       if (data.id == null){
         AuthApi.registerUser(
             name: name,
             thumbnailUrl: thumbnailUrl,
             handle: handle,
             pictureUrl: pictureUrl,
             email: email,
             uid: id,
             isAnonymous: isAnonymous,
             platform: platform,
             deviceToken: token
         );

         data = UserDetails(
             name: name,
             thumbnailUrl: thumbnailUrl,
             handle: handle,
             pictureUrl: pictureUrl,
             email: email,
             id: id,
             currency: DEFAULT_CURRENCY,
             isAnonymous: isAnonymous,
             platform: platform,
             deviceToken: token
         );
       }

       data = data.copyWith(
         deviceToken: token,
         thumbnailUrl: thumbnailUrl,
         platform: platform,
         pictureUrl: pictureUrl
       );

       UserApi.updateUserInfo(
           oData: data.toJson(),
          currUserId: data.id,
       );
    }

    catch (ex){
      print('user non registred...');

      AuthApi.registerUser(
          name: name,
          thumbnailUrl: thumbnailUrl,
          handle: handle,
          pictureUrl: pictureUrl,
          email: email,
          uid: id,
          isAnonymous: isAnonymous,
          platform: platform,
          deviceToken: token
      );

      data = UserDetails(
          name: name,
          thumbnailUrl: thumbnailUrl,
          handle: handle,
          pictureUrl: pictureUrl,
          email: email,
          id: id,
          currency: DEFAULT_CURRENCY,
          isAnonymous: isAnonymous,
          platform: platform,
          deviceToken: token
      );
    }

    return data;
  }
}
