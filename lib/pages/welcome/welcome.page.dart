import 'dart:ui';

import 'package:Awoshe/components/Buttons/awoshe_button.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class WelcomePage extends StatelessWidget {

  static AuthStore authStore;

  void _onBrowse(BuildContext context) async {
    try {
      await authStore.signInAnonymously();
    AppRouter.router.navigateTo(context, Routes.home, replace: true, clearStack: true);
    } 
    catch (ex) {
      ShowFlushToast(context, ToastType.ERROR, ex);
    }
    
  }

  void _onSignIn(BuildContext context) {
    AppRouter.router.navigateTo(context, Routes.login, replace: true, clearStack: true);
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    authStore = Provider.of<AuthStore>(context);
    WidgetsBinding.instance.addPostFrameCallback( (_) {
      if (!authStore.hasInternet) {
        ShowFlushToast(
            context, ToastType.ERROR, 'Internet connection is required!');

        // just to avoid rebuilds;
        authStore.setInternetPresence(true);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
    height: size.height,
    child: Stack(
      children: <Widget>[
        /*Align(
          alignment: Alignment.center,
          child: Container(
              height: 280.0,
              width: 280.0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(Assets.awosheLogo),
                ),
              )),
        ),*/
        Container(
          child: Container(),
          margin: EdgeInsets.only(top: 10.0, bottom: 70.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: ExactAssetImage(Assets.welcomeBG),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Button(
                borderRadius: 0.0,
                width: (size.width * 0.5),
                child:  Observer(
                  builder: (context){
                    return authStore.authenticating ? Container(
                      height: 30.0,
                      child: AwosheDotLoading(
                        color: Colors.white,
                      ),
                    ) 
                    : Text(
                      'Browse',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ); 
                
                  },
                ),
                
                onPressed: () => _onBrowse(context),
                backgroundColor: secondaryColor,
              ),
              Button(
                borderRadius: 0.0,
                width: (size.width * 0.5),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () => _onSignIn(context),
                backgroundColor: primaryColor,
              ),
            ],
          ),
        ),
      ],

    ),
      ),
    );
  }
}
