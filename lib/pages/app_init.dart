import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/application_initialization/application_initialization_bloc.dart';
import 'package:Awoshe/logic/bloc/application_initialization/application_initialization_event.dart';
import 'package:Awoshe/logic/bloc/application_initialization/application_initialization_state.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/stores/app_init/app_init_store.dart';
import 'package:Awoshe/services/analytics.service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
import 'package:flare_flutter/flare_actor.dart';

Localization localization;

class InitializationPage extends StatefulWidget {
  // analytics is initialized here. Dont remove this. we need this in future after launching awoshe
  static final OptOutAwareFirebaseAnalytics awosheAnalytics =
      OptOutAwareFirebaseAnalytics(FirebaseAnalytics());
  static final SentryClient sentry =
      new SentryClient(dsn: SENTRY_DSN); // configure sentry
  InitializationPage({Key key}) : super(key: key);
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  ApplicationInitializationBloc bloc;
  AppInitStore initStore;

  @override
  void initState() {
    super.initState();
    initStore = Provider.of<AppInitStore>(context, listen: false);
    initStore.setupApp();
    bloc = BlocProvider.of<ApplicationInitializationBloc>(context);
    bloc.dispatch(ApplicationInitializationStart());
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    localization = Localization.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Container(
            child: Center(
              child: BlocBuilder<ApplicationInitializationBloc,
                  ApplicationInitializationState>(
                builder: (BuildContext context,
                    ApplicationInitializationState state) {
                  if (state is ApplicationInitializationDone) {
                    // Once the initialization is complete, let's move to another page
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      initStore.initApp (this.context);
                    });
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: FlareActor(
                              "assets/Awoshe.flr",
                              alignment: Alignment.center,
                              animation: 'Awoshe',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      /*Text('Initialization in progress... ${state.progress}%'),*/
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50.0,
          margin:const EdgeInsets.only(bottom:15.0) ,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(child: Text('Curated High-end Contemporary Designs Made in Africa', style: TextStyle(fontSize: 10.0)),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Platform proudly made with',
                  style: TextStyle(fontSize: 10.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'assets/svg/Icons/heartfilled.svg',
                    height: 8,
                    width: 8,
                    color: Colors.red,
                  ),
                ),
                Text(
                  ' in ',
                  style: TextStyle(fontSize: 10.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    'assets/svg/swissflag.svg',
                    height: 8,
                    width: 8,
                  ),
                ),
              ],
            ),

          ],
        )
      )
    );
  }
}
