import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/common/exceptionprint.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWithSocialMedia extends StatelessWidget {
  final double height;
  final double buttonWidth;
  final AuthStore authStore;

  LoginWithSocialMedia({this.height, this.buttonWidth, this.authStore});

  _loginUpWithFacebook(BuildContext context) async {
    UserStore userStore = Provider.of<UserStore>(context);

    try {
      await authStore.loginWithFaceBook();
//      authStore.authService.fetchUserDetail(userId)
      if (AppData.isPromotionMode && !userStore.details.isDesigner) {
        AppRouter.router
            .navigateTo(context, Routes.promotion, replace: true, clearStack: true);
      } else {
        AppRouter.router.navigateTo(context, Routes.home,
            replace: true, clearStack: true);
      }    } catch (e, stackTrace) {
      printException(e, stackTrace, "Error while _signInWithFacebook");
    }
  }

  _loginUpWithGoogle(BuildContext context) async {
    UserStore userStore = Provider.of<UserStore>(context);

    try {
      await authStore.loginWithGoogle();
      if (AppData.isPromotionMode && !userStore.details.isDesigner) {
        AppRouter.router
            .navigateTo(context, Routes.promotion, replace: true, clearStack: true);
      } else {
        AppRouter.router.navigateTo(context, Routes.home,
            replace: true, clearStack: true);
      }    } catch (e, stackTrace) {
      printException(e, stackTrace, "Error while _signInWithGoogle");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              Localization.of(context).signInWith,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                  minWidth: this.buttonWidth,
                  height: 45.0,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {
                      // Perform some action
                      _loginUpWithFacebook(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(Assets.facebook),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Text(
                            ' Facebook',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
              ButtonTheme(
                  minWidth: this.buttonWidth,
                  height: 45.0,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {
                      // Perform some action
                      _loginUpWithGoogle(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(Assets.google),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Text(
                            'Google',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}