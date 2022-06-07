import 'package:Awoshe/database/database_provider.dart';
import 'package:Awoshe/logic/stores/app_init/app_init_store.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/logic/stores/cache/CacheManagerStore.dart';
import 'package:Awoshe/logic/stores/currency/currency_store.dart';
import 'package:Awoshe/logic/stores/feeds/feeds_store.dart';
import 'package:Awoshe/logic/stores/upload/upload_store.dart';
import 'package:Awoshe/pages/app_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'logic/bloc/application_initialization/application_initialization_bloc.dart';
import 'logic/bloc/authentication/authentication_bloc.dart';
import 'logic/stores/cart/cart_store.dart';
import 'logic/stores/message/message_store.dart';
import 'logic/stores/user/user_store.dart';

// Application entry point
void main() {
  //Restrict orientation to only portrait.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Application());

}

class Application extends StatelessWidget {
  final DatabaseProvider dbProvider = DatabaseProvider();
  final UserStore userStore = UserStore();
  final UploadStore uploadStore = UploadStore();
  final MessageStore messageStore = MessageStore();
  final CurrencyStore currencyStore = CurrencyStore();
  final CacheManagerStore cacheManagerStore = CacheManagerStore();

  Color _randomStatusColor = Colors.black;
  Color _randomNavigationColor = Colors.black;

  bool _useWhiteStatusBarForeground;
//  bool _useWhiteNavigationBarForeground;

  Application() {
    final router = new Router();
    Routes.configureRoutes(router);
    AppRouter.router = router;
  }



  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
     // fetchLinkData();
      if (_useWhiteStatusBarForeground != null)
        FlutterStatusbarcolor.setStatusBarWhiteForeground(
            _useWhiteStatusBarForeground);
    }
    //super.didChangeAppLifecycleState(state);
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        _useWhiteStatusBarForeground = false;
        // _useWhiteNavigationBarForeground = true;
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        //FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        _useWhiteStatusBarForeground = false;
        //_useWhiteNavigationBarForeground = false;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    changeStatusColor(Colors.transparent);

    final AuthStore authStore = AuthStore(userStore: userStore);
    final AppInitStore initStore = AppInitStore();


    return MultiProvider(
      providers: [
        Provider<DatabaseProvider>.value(
            value: dbProvider
        ),

        Provider<AuthenticationBloc>.value(
          value: AuthenticationBloc(
            userStore: userStore,
            authStore: authStore,
          ),
        ),
        Provider<AuthStore>.value(
          value: authStore,
        ),
        Provider<UserStore>.value(value: userStore),
        Provider<CartStore>.value(value: CartStore(currencyStore, userStore)),
        Provider<UploadStore>.value(value: uploadStore),
        Provider<MessageStore>.value(value: messageStore),
        Provider<CurrencyStore>.value(value: currencyStore),
        Provider<AppInitStore>.value(value: initStore),
        Provider<FeedsStore>.value(value: FeedsStore()),
        Provider<CacheManagerStore>.value(value: cacheManagerStore),

      ],

      child: MaterialApp(
          home: BlocProvider(
            builder: (context) => ApplicationInitializationBloc(),
            child: InitializationPage(),
          ),
          title: 'Explore',
          theme: appTheme,
          onGenerateRoute: AppRouter.router.generator,
          localizationsDelegates: [
            const AwosheLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('en'), const Locale('fr')],
          debugShowCheckedModeBanner: false),
    );
  }
}
