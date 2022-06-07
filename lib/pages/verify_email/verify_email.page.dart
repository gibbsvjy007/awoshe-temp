import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/pages/login/login.style.dart';
import 'package:Awoshe/services/push_notification.service.dart';
import 'package:Awoshe/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Awoshe/services/auth.service.dart';
import 'package:Awoshe/common/exceptionprint.dart';
import 'package:Awoshe/utils/awoshe.dart';
import 'dart:async';
import 'package:Awoshe/router.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key key}) : super(key: key);
  @override
  VerifyEmailPageState createState() => new VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  ScrollController scrollController = new ScrollController();
  String email = "";
  static FirebaseUser user;
  UserService userService = new UserService();
  UserStore userStore;

  @override
  void initState() {
    super.initState();
    this._checkVerification();
    userStore = Provider.of<UserStore>(context);
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  void _onEmailVerificationDone() {
    if (this.context != null) {
      if (AppData.isPromotionMode && !userStore.details.isDesigner) {
        AppRouter.router
            .navigateTo(context, Routes.promotion, replace: true, clearStack: true);
      } else {
        AppRouter.router.navigateTo(this.context, Routes.home,
            replace: true, clearStack: true);
      }
    }
  }

  _checkVerification() async {

    bool isTimeout = false;
    try {
      user = await AuthenticationService.instance.getCurrentUser();
      if (user != null) {
        print(user.toString());
        print(email + " :: " + this.email);
        print(user.email);
        this.setState(() {
          this.email = user.email;
        });
      }
      // polling
      Timer.periodic(Duration(seconds: 1), (Timer t) async {
        print(user);
        if (user != null) {
          await user.reload();
          user = await AuthenticationService.instance.getCurrentUser();
        }
        print("isEmailVerified: ${user.isEmailVerified}");
        if (user != null && user.isEmailVerified) {
          t.cancel();
          this.userService.verificationCallable();
          print("CART CREATED SUCCESSFULLY");
          /// setup pushnotification once user creates an account successfully.
          PushNotificationService.setupNotification(user.uid);
          Awoshe.showToast("Email verification successfully completed", this.context);
          _onEmailVerificationDone();
          return;
        }
        if (isTimeout) {
          print("Email verification Timed Out");
          t.cancel();
        }
      });
      new Future.delayed(new Duration(seconds: 60), () => isTimeout = true);
    } catch (e, stackTrace) {
      printException(e, stackTrace, "Error while email verification");
      Awoshe.showToast(e.message, this.context);
    }
  }

  void _resendVerificationEmail() async {
    print("resend");
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      user = await AuthenticationService.instance.getCurrentUser();
      await user.sendEmailVerification();
    }
    Awoshe.showToast("Verfication email has been sent", this.context);
  }

  void _logout() async {
    print("logout");
    await AuthenticationService.instance.signOut();
    Navigator.of(context).pop();
    AppRouter.router.navigateTo(this.context, Routes.login, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _verificationScreen());
  }

  Widget _verificationScreen() {
    final Size screenSize = MediaQuery.of(context).size;
    return new SingleChildScrollView(
        controller: scrollController,
        child: new Container(
          padding: new EdgeInsets.all(25.0),
          decoration: new BoxDecoration(image: backgroundImage),
          height: screenSize.height,
          child: new Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 80.0)),
              new Container(
                height: 80.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new Text(
                        Localization.of(context).verifyEmailText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 26.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new RoundedButton(
                          buttonName: this.email ?? '',
                          width: screenSize.width,
                          height: 50.0,
                          buttonColor: secondaryColor),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ButtonTheme(
                            minWidth: 150.0,
                            height: 50.0,
                            child: new RaisedButton(
                              color: primaryColor,
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  top: 13.0,
                                  bottom: 13.0,
                                  right: 30.0),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              onPressed: () {
                                // Perform some action
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: new Text("Logout"),
                                      content: new Text("Are you sure you want to logout ?"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("DISCARD"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text("LOGOUT"),
                                          onPressed: _logout,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    ' Sign out',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                        new ButtonTheme(
                            minWidth: 150.0,
                            height: 50.0,
                            child: new RaisedButton(
                              color: primaryColor,
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  top: 13.0,
                                  bottom: 13.0,
                                  right: 30.0),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              onPressed: _resendVerificationEmail,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    ' Resend',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
