import 'dart:async';
import 'dart:io';
import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/common/exceptionprint.dart';
import 'package:Awoshe/database/database_provider.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/logic/stores/cache/cache_stores/UserDetailsCacheStore.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/exception/AppInitException.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/services/push_notification.service.dart';
import 'package:Awoshe/utils/message_utils.dart';
import 'package:Awoshe/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/router.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

part 'app_init_store.g.dart';

class AppInitStore = _AppInitStore with _$AppInitStore;

/// This class holds logic code about app initialization process.
/// * version check
/// * remote config
/// * get currencies transformation values
/// * verify if there is user logged
/// * choose proper landing page.
abstract class _AppInitStore with Store {

  //bool isAppVersionValid = false;

  @observable
  bool hasInternetPresence;

  @action
  void setInternetPresence(bool flag) => hasInternetPresence = flag;
    
  Timer _internetTimer;
  UserStore _userStore;
  UploadStore _uploadStore;
  CurrencyStore _currencyStore;
  FeedsStore _feedStore;

  setupApp() {
    /// Set-up error reporting
    FlutterError.onError = (FlutterErrorDetails error) {
      printException(error.exception, error.stack, error.context.toString());
    };
    MessageUtils.setChatWindowOpen(false);
  }

  /// Get Current installed version of app
  Future<int> _getCurrentAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    print(info.version);
    return int.parse(info.version.trim().replaceAll(".", ""));
  }

  ///Get Latest version info from firebase config
  Future<RemoteConfig> _getRemoteConfig() async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

      print(remoteConfig.remoteConfigSettings.debugMode);
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 1));
      await remoteConfig.activateFetched();
      return remoteConfig;
    } 

    on FetchThrottledException catch (ex){
      // Fetch throttled.
      print(ex);
      print(ex.throttleEnd);
      print('AppInitStore::_getRemoteConfig $ex');

      throw AppInitException(
        message: 'Error getting remote app configs',
        type: AppInitError.APP_VERSION_ERROR
      );
    }
       
  }
  
  checkAppVersion(BuildContext context) async {
    RemoteConfig remoteConfig;
    
    try {
      int currentVersion = await _getCurrentAppVersion();
      remoteConfig = await _getRemoteConfig();
      

      int newVersion = int.parse(
          remoteConfig.getString('min_app_version').trim().replaceAll(".", ""));
      print(currentVersion);
      print(newVersion);
      
      if (newVersion > currentVersion) {
        Utils.showAppUpdateDialog(context, remoteConfig).then((val) {
          if (val == null)
            getLandingRoute(context, remoteConfig);
        });
      } 
      else {
        /// if current version is equal then just continue
        getLandingRoute(context, remoteConfig);
      }
    } 

    catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
            'used');
      getLandingRoute(context, remoteConfig);
    }
  }

  initApp(BuildContext context) async {
    _userStore = Provider.of<UserStore>(context, listen: false);
    _currencyStore = Provider.of<CurrencyStore>(context, listen: false);
    _uploadStore = Provider.of<UploadStore>(context, listen: false);
    _feedStore = Provider.of<FeedsStore>(context, listen: false);

    // use try-catch because if there is no internet presence 
    // checkInternetPresence will throw an exception
    
    try {
      await checkInternetPresence();
      setInternetPresence(true);
      checkAppVersion(context);
    } 
    
    catch (ex){
      setInternetPresence(false);
      // must start with cached mode.
      startWithCache(context);
    }
  }
  
  Future<void> startWithCache(BuildContext context) async { 

    try {
      await _initLocalDatabase(context);
      
      await _initCurrencyValues(context);

      await _setupUserFromCache(context);

      goToRoute(context, Routes.home, clearStack: true, replace: true);
       
    } 
    
    catch (ex){
      print('$ex');
      goToRoute(context, Routes.welcome, clearStack: true, replace: true);
    }
  }

  /// This method check if there is internet presence. If there isn't
  /// it starts a timer to check internet presence again after 1.5 seconds.
  /// When internet presence is detected the timer stops and we get app startup data
  /// like Firebase remote configs, update user token, presence and start message service and 
  /// listening for new feeds.
  Future<bool> checkInternetPresence() async {
    bool results = false;
    
    try {
      final result = await InternetAddress.lookup('awoshe.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        results = true;
        if (_internetTimer != null){
          _internetTimer.cancel();
          _internetTimer = null;
          
          setInternetPresence(results);
          _resettingAppConfigs();
          print('We got connection timer shutdown!');
          
        }
      }
    } 
    on SocketException catch (_) {
      // startup internet listener!
      if (_internetTimer == null){
        _internetTimer = Timer.periodic(Duration(milliseconds: 1500), 
          (data) async {
            print('Internet timer callback');
            checkInternetPresence();
          });
      }
      throw AppInitException(
        message: 'No Internet presence detected',
        type: AppInitError.NO_INTERNET
      );
    }
    return results;
  }

  bool _settingPromotion(RemoteConfig remoteConfig){
        bool isPromotionMode = false;

      if (remoteConfig != null)
        isPromotionMode = remoteConfig.getBool('promotion_mode');
      
      print('PROMOTION_MODE_' + isPromotionMode.toString());
      AppData.isPromotionMode = isPromotionMode;
      return isPromotionMode;
  }

  Future<void> getLandingRoute(BuildContext context, RemoteConfig remoteConfig) async {
    
    try {
      await _initCurrencyValues(context);

      FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
      await _initLocalDatabase(context);
      print('Current user $firebaseUser');
      var isPromotionMode = _settingPromotion(remoteConfig);
      
      if (firebaseUser != null && firebaseUser.uid != null) {
        if (firebaseUser.providerData != null && firebaseUser.providerData.length > 0) {
          
          List<UserInfo> providerData = firebaseUser.providerData.where((dt) => dt.providerId == "facebook.com").toList();
          UserDetails userDetails = await setupUser(context, firebaseUser);

          if (providerData != null && providerData.length > 0) {
            if (isPromotionMode && !userDetails.isDesigner) {
              // go to promotion page
              goToRoute(context, Routes.promotion, clearStack: true, replace: true);
              
            } 
            else {
              goToRoute(context, Routes.home, clearStack: true, replace: true);
            }
          } 
          
          else {
            print('________________firebaseUser__________________');
            if (!firebaseUser.isEmailVerified) {
              await firebaseUser.reload(); // reason to reload is if admin had update the user then
            }
            print(firebaseUser);
            print(firebaseUser.displayName);
            if (firebaseUser.isEmailVerified) {
              if (isPromotionMode && !userDetails.isDesigner) {
                goToRoute(context, Routes.promotion, clearStack: true, replace: true);
              } 
              else {
                goToRoute(context, Routes.home, clearStack: true, replace: true);
              }
            }
            else {
              goToRoute(context, Routes.welcome, clearStack: true, replace: true);
              await Utils.showEmailVerificationDialog(context);
            }
          }
        } 
        
        else {
          if (firebaseUser != null && firebaseUser.isAnonymous) {
            UserDetails userDetails = await setupUser(context, firebaseUser);

            print(userDetails.toJson().toString());
            goToRoute(context, Routes.home, clearStack: true, replace: true);
          } 
          
          else {
            goToRoute(context, Routes.welcome, clearStack: true, replace: true);
          }
        }
      } // end if there is user

      else {
        goToRoute(context, Routes.welcome, clearStack: true, replace: true);
      }
    }

    on AppInitException catch (e, stackTrace) {
      if (e.type == AppInitError.NO_INTERNET)
        Provider.of<AuthStore>(context, listen: false).setInternetPresence(false);

      printException(e, stackTrace, "Error while loading landing page");
      goToRoute(context, Routes.welcome, replace: true, clearStack: true);
    }
  }

  Future<void> _setupUserFromCache(BuildContext context,) async {

    try {
      AuthenticationBloc authenticationBloc = Provider.of<AuthenticationBloc>(
        context, listen: false);

      UserDetails userDetails = await UserDetailsCacheStore.instance.getData();
      authenticationBloc.setUserDetails(userDetails);
      _userStore.setUserDetails(userDetails);

      // TODO: NEEDS TO SETUP MESSAGING and PUSH NOTIFICATIONS
      // but offline?
      // maybe a listener if the connection backs update all the things
    } 
    
    catch (ex){
      throw ex;
    }
  }

  Future<UserDetails> setupUser(BuildContext context, FirebaseUser firebaseUser) async {
    AuthenticationBloc authenticationBloc = Provider.of<AuthenticationBloc>(
        context, listen: false);
    
    /// TODO - later we will remove authentication bloc and will only use auth store
    //UserStore userStore = Provider.of<UserStore>(context, listen: false);
    UserDetails userDetails;
    
    print("setupUser: ");
    print('Is User Anonymous: ' + firebaseUser.isAnonymous.toString());
    var userCacheStore = UserDetailsCacheStore.instance;
    
    if (firebaseUser.isAnonymous) {
      userDetails =
      await AuthenticationService.instance.setAnonymousUser(firebaseUser);
      authenticationBloc.setUserDetails(userDetails);
      userCacheStore.setData(userDetails);
    }
    
    else {
      /// fetch user profile and set data
      userDetails = await AuthenticationService.instance.fetchUserDetail(firebaseUser.uid);
      userCacheStore.setData(userDetails);

      print(userDetails.toJson());
      authenticationBloc.setUserDetails(userDetails);
      
      final FirebaseMessaging _messaging = FirebaseMessaging();
      String deviceToken = await _messaging.getToken();
      _userStore.updateDeviceToken(deviceToken); /// update users device token

      _uploadStore.loadCollections(firebaseUser.uid);
    }

    PushNotificationService.setupNotification(firebaseUser.uid);
    return userDetails;
  }


  /// Allows you choose a route and go there.
  /// 
  Future<void> goToRoute(BuildContext context,String path, 
    {bool replace = false, bool clearStack = false,} ) =>
      AppRouter.router.navigateTo(context, path, 
        replace: replace, clearStack: clearStack);  

  /// Init and load local database resources.
  /// 
  Future<void> _initLocalDatabase(BuildContext context) async {
    try {
      var provider = Provider.of<DatabaseProvider>(context);
      await provider.initDatabase();
      Provider
        .of<UploadStore>(context)
        .progressList = await provider.loadData();
    }

    catch (ex){
      throw AppInitException(
        message: 'Error loading local db resources',
        type: AppInitError.LOCAL_DB_ERROR,
      );
    }
    
  }      

  /// getting currency conversion values from realtime db.
  /// 
  Future<void> _initCurrencyValues(BuildContext context) async {
    return _currencyStore.init();
  }

  void _resettingAppConfigs() async {
    _getCurrentAppVersion();
    MessageUtils.setChatWindowOpen(false);
    _settingPromotion( await _getRemoteConfig() ) ;
    final FirebaseMessaging _messaging = FirebaseMessaging();
    String deviceToken = await _messaging.getToken();
    
    _userStore.updateDeviceToken(deviceToken); /// update users device token
    _currencyStore.init();
    
    if (_userStore.details.isDesigner)
      _uploadStore.loadCollections(_userStore.details.id);

    //if (!_feedStore.isFeedSubscribed)
      _feedStore.unSubscribeToFeeds();
      _feedStore.subscribeToFeeds();
  }

}
// get remote settings
// setup 
// start frebase message
