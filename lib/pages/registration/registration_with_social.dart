import 'package:Awoshe/common/exceptionprint.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/router.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/utils/assets.dart';
import 'package:Awoshe/utils/awoshe.dart';
import 'package:flutter/material.dart';

class SignupWithSocialMedia extends StatelessWidget {

  final double buttonWidth;

  SignupWithSocialMedia({this.buttonWidth});

  _signUpWithFacebook(BuildContext context) async {
    try {
      await AuthenticationService.instance.signInWithFacebook();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } catch (e, stackTrace) {
      printException(e, stackTrace, "Error while _signInWithFacebook");
      Awoshe.showToast(stackTrace, context);
    }
  }

  _signUpWithGoogle(BuildContext context) async {
    try {
      await AuthenticationService.instance.signInWithGoogle();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } catch (e, stackTrace) {
      printException(e, stackTrace, "Error while _signInWithFacebook");
      Awoshe.showToast(stackTrace, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              Localization.of(context).signUpWith,
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
                  minWidth: buttonWidth,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {
                      // Perform some action
                      _signUpWithFacebook(context);
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
                  minWidth: buttonWidth,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    onPressed: () {
                      // Perform some action
                      _signUpWithGoogle(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(Assets.google),
                        Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Text(
                            ' Google',
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
