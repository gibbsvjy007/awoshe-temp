import 'package:Awoshe/common/app.data.dart';
import 'package:Awoshe/components/closefab.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_event.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_login_form_bloc.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_state.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/pages/login/login_with_social.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'login.style.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/Buttons/textButton.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  LoginFormState createState() => new LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ScrollController scrollController = new ScrollController();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  Size screenSize;
  LoginFormBloc loginFormBloc;
  AuthenticationBloc authenticationBloc;
  AuthStore authStore;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loginFormBloc = LoginFormBloc();
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authStore = Provider.of<AuthStore>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    print('Login form dispose');
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    loginFormBloc?.dispose();
    scrollController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  void listenStateChanges(context, state) {
    print(state.toString());
    if (state is Authenticated) {
      // navigate to homepage once login is successful.
      if (AppData.isPromotionMode &&
          !authenticationBloc.currentUser.isDesigner) {

        AppRouter.router.navigateTo(context, Routes.promotion,
            replace: true, clearStack: true);
      }

      else {
        print('GOING TO HOME');
        AppRouter.router.navigateTo(this.context, Routes.home,
            replace: true, clearStack: true);
      }
    }

    if (state is AuthenticationFailure) {
      ShowFlushToast(
          context, ToastType.ERROR, state?.error ?? "Authentication failed");
    }
  }

  void onLoginPressed(BuildContext context, AuthenticationState state) async {
    print('onLoginPressed');
    authenticationBloc.dispatch(AuthenticationEventLogin(
        event: AuthenticationEventType.working,
        email: _emailController.text,
        password: _passwordController.text));
  }

  Widget emailField() => StreamBuilder<String>(
      stream: loginFormBloc.email,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).email,
            obscureText: false,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.emailAddress,
            textStyle: textStyle,
            controller: _emailController,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: loginFormBloc.changeEmail);
      });

  Widget passwordField() => StreamBuilder<String>(
      stream: loginFormBloc.password,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).password,
            obscureText: true,
            controller: _passwordController,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: loginFormBloc.changePassword);
      });

  Widget loginButton(AuthenticationState state) => StreamBuilder<bool>(
        stream: loginFormBloc.submitValid,
        builder: (context, snapshot) {
          return AwosheButton(
            radius: 30.0,
            onTap: (snapshot.hasData && snapshot.data)
                ? () => onLoginPressed(context, state)
                : null,
            childWidget: state is Authenticating
                ? DotSpinner()
                : Text(Localization.of(context).login, style: buttonTextStyle),
            width: screenSize.width,
            buttonColor: primaryColor,
          );
        },
      );

  Widget _buildLoginForm(BuildContext context, AuthenticationState state) {
    screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: scrollController,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            height: screenSize.height,
            decoration: BoxDecoration(
              image: backgroundImage,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: screenSize.height * 0.07),
                Container(
                  height: screenSize.height * 0.13,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          Localization
                              .of(context)
                              .loginText1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          Localization
                              .of(context)
                              .loginText2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Flexible(
                  child: Container(
                    height: screenSize.height * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                      buttonName:
                                      Localization
                                          .of(context)
                                          .registerHere,
                                      onPressed: () {
                                        AppRouter.router.navigateTo(
                                            this.context, Routes.signup,
                                            replace: false);
                                      },
                                      shouldUnderlined: true,
                                      buttonTextStyle: buttonTextStyle)
                                ],
                              ),
                              emailField(),
                              passwordField(),
                              loginButton(state),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                  buttonName:
                                  Localization
                                      .of(context)
                                      .forgotPasswordTitle,
                                  onPressed: () {
                                    AppRouter.router.navigateTo(
                                        this.context, Routes.forgotPassword);
                                  },
                                  shouldUnderlined: true,
                                  buttonTextStyle: buttonTextStyle)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                LoginWithSocialMedia(
                    authStore: authStore,
                    height: screenSize.height * 0.17,
                    buttonWidth: screenSize.width * 0.40),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: AwosheCloseFab(
              onPressed: () =>
                  AppRouter.router.navigateTo(
                      context, Routes.welcome, replace: true, clearStack: true),
              putThere: Alignment.topRight,),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext text) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: listenStateChanges,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          SystemChrome.restoreSystemUIOverlays();
          return _buildLoginForm(context, state);
        },
      ),
    );
  }
}
