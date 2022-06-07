import 'package:Awoshe/logic/bloc/registration/registration_bloc.dart';
import 'package:Awoshe/logic/bloc/registration/registration_event.dart';
import 'package:Awoshe/logic/bloc/registration/registration_form_bloc.dart';
import 'package:Awoshe/logic/bloc/registration/registration_state.dart';
import 'package:Awoshe/pages/registration/registration.style.dart';
import 'package:Awoshe/pages/registration/registration_with_social.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/awoshe_alert_dialog.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/Buttons/textButton.dart';
import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:flutter/rendering.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override
  RegistrationFormState createState() => new RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ScrollController scrollController = new ScrollController();
  RegistrationBloc _registrationBloc;
  RegistrationFormBloc _registrationFormBloc;

  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;
  TextEditingController _userNameController;
  Size screenSize;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    _registrationFormBloc = RegistrationFormBloc();
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _registrationBloc?.dispose();
    _registrationFormBloc?.dispose();
    _nameController?.dispose();
    scrollController?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _userNameController?.dispose();
    super.dispose();
  }

  void listenStateChanges(context, state) {
    if (state is RegistrationSuccess) {
      // Handle Successs
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AwosheAlertDialog(
            title: Text(
              "Thank you",
              style:
              TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Registration link has been sent to your email. Please verify your email and login again. Thank you!",
                  style: textStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            hasWarning: true,
            onCancel: () => Navigator.of(context).pop(),
            onConfirm: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              AppRouter.router.navigateTo(context, Routes.login);
            },
          );
        },
      );
    }
    if (state is RegistrationWarning) {
      ShowFlushToast(
          context, ToastType.WARNING, state?.error ?? "Registration failed");
    }
    if (state is RegistrationFailure) {
      ShowFlushToast(
          context, ToastType.ERROR, state?.error ?? "Registration failed");
    }
  }

  void _openPrivacyPolicy() {}

  void onRegisterPressed(BuildContext context, RegistrationState state) async {
    _registrationBloc.dispatch(RegistrationEventProcess(
        event: RegistrationEventType.working,
        email: _emailController.text,
        name: _nameController.text,
        handle: _userNameController.text,
        password: _passwordController.text));
  }

  Widget nameField() => StreamBuilder(
      stream: _registrationFormBloc.name,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).name,
            obscureText: false,
            controller: _nameController,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _registrationFormBloc.changeName);
      });

  Widget userNameField() => StreamBuilder(
      stream: _registrationFormBloc.userName,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).username,
            obscureText: false,
            controller: _userNameController,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.text,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _registrationFormBloc.changeUserName);
      });

  Widget emailField() => StreamBuilder(
      stream: _registrationFormBloc.email,
      builder: (context, snapshot) {
        return InputFieldV2(
            hintText: Localization.of(context).email,
            obscureText: false,
            controller: _emailController,
            hintStyle: TextStyle(color: secondaryColor),
            textInputType: TextInputType.emailAddress,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            textAlign: TextAlign.center,
            bottomMargin: 15.0,
            errorText: snapshot.error,
            onChanged: _registrationFormBloc.changeEmail);
      });

  Widget passwordField() => StreamBuilder(
      stream: _registrationFormBloc.password,
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
            onChanged: _registrationFormBloc.changePassword);
      });

  Widget signupButton(RegistrationState state) {
    return StreamBuilder(
      stream: _registrationFormBloc.submitValid,
      builder: (context, snapshot) {
        return AwosheButton(
          radius: 30.0,
          onTap: (snapshot.hasData && snapshot.data)
              ? () => onRegisterPressed(context, state)
              : null,
          childWidget: state is RegistrationBusy
              ? DotSpinner()
              : Text(Localization.of(context).register, style: buttonTextStyle),
          width: screenSize.width,
          buttonColor: primaryColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: listenStateChanges,
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return _buildRegistrationForm(context, state);
        },
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context, RegistrationState state) {
    screenSize = MediaQuery.of(context).size;
    return Container(
            height: screenSize.height,
            decoration: BoxDecoration(image: backgroundImage),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: .0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.07),
              Container(
                height: screenSize.height * 0.12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        Localization
                            .of(context)
                            .signupWelcomeText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
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
              Container(
                //height: screenSize.height * 0.50,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                                  buttonName: Localization
                                      .of(context)
                                      .alreadyHaveAccount,
                                  shouldUnderlined: true,
                                  onPressed: () =>
                                      Navigator.pop(context),

                                  buttonTextStyle: buttonTextStyle)
                            ],
                          ),
                          nameField(),
                          userNameField(),
                          emailField(),
                          passwordField(),
                          signupButton(state)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                            buttonName: Localization
                                .of(context)
                                .privacyPolicy,
                            onPressed: _openPrivacyPolicy,
                            shouldUnderlined: true,
                            buttonTextStyle: buttonTextStyle)
                      ],
                    ),

                    SignupWithSocialMedia(
                        buttonWidth: screenSize.width * 0.40
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
            ),
        );
  }
}
