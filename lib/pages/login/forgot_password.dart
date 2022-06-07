import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_event.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_login_form_bloc.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_state.dart';
import 'package:Awoshe/pages/login/login.style.dart';
import 'package:Awoshe/services/user.service.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:flutter/material.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);
  @override
  ForgotPasswordPageState createState() => new ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ScrollController scrollController = new ScrollController();
  TextEditingController emailController = TextEditingController();
  LoginFormBloc loginFormBloc;
  AuthenticationBloc authenticationBloc;
  Size screenSize;

  static FirebaseUser user;
  UserService userService = new UserService();

  @override
  void dispose() {
    scrollController.dispose();
    emailController.dispose();
    loginFormBloc?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loginFormBloc = LoginFormBloc();
    super.initState();
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    listenStateChanges();
  }

  void listenStateChanges() {
    authenticationBloc.state.listen((state) {
      if (state is ResetPasswordSuccess) {
        Navigator.pop(context);
      }
      if (state is ResetPasswordError) {
        ShowFlushToast(
            context, ToastType.ERROR, state?.error ?? "Forgot password failed");
      }
    });

  }

  Widget emailField() => StreamBuilder<String>(
      stream: loginFormBloc.forgotPasswordEmail,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).email,
            obscureText: false,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.emailAddress,
            textStyle: textStyle,
            controller: emailController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 10.0,
            errorText: snapshot.error,
            onChanged: loginFormBloc.changeForgotPasswordEmail);
      });

  onButtonPressed() {
    if (emailController.text == null || emailController.text == "") {
      ShowFlushToast(context, ToastType.INFO, "Please enter email");
      return;
    }
    print(authenticationBloc.currentState.toString());
    authenticationBloc.dispatch(AuthenticationEventReset(
        event: AuthenticationEventType.forgotPassword,
        email: emailController.text));
  }

  Widget forgotButton() => AwosheButton(
        radius: 30.0,
        onTap: () => onButtonPressed(),
        childWidget:
            Text(Localization.of(context).send, style: buttonTextStyle),
        width: screenSize.width,
        buttonColor: primaryColor,
      );

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          _verificationScreen(context),
          AwosheCloseFab(
            putThere: Alignment.topRight,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _verificationScreen(context) {
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
                        "Please enter your email",
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
                    emailField(),
                    Text(
                      "Your confirmation link will be sent to your email address.",
                      style: TextStyle(color: Colors.white70, fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    forgotButton()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
