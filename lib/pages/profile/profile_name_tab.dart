import 'package:Awoshe/components/Buttons/roundedButton.dart';
import 'package:Awoshe/components/TextFields/inputField.dart';
import 'package:Awoshe/components/TextFields/textArea.dart';
import 'package:Awoshe/components/appBar.dart';
import 'package:Awoshe/constants.dart';
import 'package:Awoshe/localization/localization.dart';
import 'package:Awoshe/logic/bloc/profile/ProfileNameTabBloc.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/utils/flush_toast.dart';
import 'package:Awoshe/widgets/dot_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileNameTab extends StatefulWidget {
  final UserStore userStore;
  final ProfileStore profileStore;
  ProfileNameTab({Key key, this.userStore, this.profileStore})
      : super(key: key);

  @override
  _ProfileNameTabState createState() => _ProfileNameTabState();
}

class _ProfileNameTabState extends State<ProfileNameTab> {
  final GlobalKey<FormState> profileNameFormKey = GlobalKey<FormState>();
  ProfileNameTabBloc bloc;
  UserDetails userDetails;
  UserStore userStore;
  ProfileStore profileStore;

  @override
  initState() {
    super.initState();
    userStore = widget.userStore;
    profileStore = widget.profileStore;
    userDetails = userStore.details;
    bloc = ProfileNameTabBloc(
        userDetails: userDetails,
        userStore: userStore,
        profileStore: profileStore);
    bloc.loadProfileInfo();
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }

  Widget profileNameForm() {
    final nameField = StreamBuilder<String>(
        stream: bloc.fullName,
        builder: (context, snapshot) {
          return InputField(
            hintText: Localization.of(context).name,
            obscureText: false,
            controller: bloc.fullNameController,
            validateFunction: bloc.validateNameField,
            hintStyle: TextStyle(
              color: secondaryColor,
            ),
            floatingLabel: Localization.of(context).name,
            textInputType: TextInputType.text,
            isBorder: true,
            textStyle: textStyle,
            textFieldColor: textFieldColor,
            leftPadding: 20.0,
            bottomMargin: 25.0,
          );
        });

    final locationField = StreamBuilder<String>(
      stream: bloc.location,
      builder: (context, snapshot) => InputField(
        hintText: Localization.of(context).location,
        hintStyle: TextStyle(color: secondaryColor),
        obscureText: false,
        floatingLabel: Localization.of(context).location,
        textInputType: TextInputType.text,
        textStyle: textStyle,
        textFieldColor: textFieldColor,
        controller: bloc.locationController,
        leftPadding: 20.0,
        bottomMargin: 25.0,
        isBorder: true,
      ),
    );

    final userNameField = StreamBuilder<String>(
      stream: bloc.userName,
      builder: (context, snapshot) => InputField(
        
        hintText: Localization.of(context).username,
        hintStyle: TextStyle(color: secondaryColor),
        obscureText: false,
        validateFunction: bloc.validateUserName,
        floatingLabel: Localization.of(context).username,
        textInputType: TextInputType.text,
        textStyle: textStyle,
        textFieldColor: textFieldColor,
        controller: bloc.userNameController,
        leftPadding: 20.0,
        bottomMargin: 25.0,
        isBorder: true,
      ),
    );

    final aboutMeField = StreamBuilder<String>(
      stream: bloc.aboutMe,
      builder: (context, snapshot) => TextAreaInput(
        hintText: Localization.of(context).about,
        hintStyle: TextStyle(color: secondaryColor),
        obscureText: false,
        floatingLabel: Localization.of(context).about,
        textInputType: TextInputType.text,
        textStyle: textStyle,
        textFieldColor: textFieldColor,
        controller: bloc.aboutMeController,
        bottomMargin: 25.0,
        maxLines: 7,
        borderRadius: APP_INPUT_RADIUS,
      ),
    );

    final saveButton = StreamBuilder<bool>(
      stream: bloc.asyncCallObservable,
      initialData: false,
      builder: (context, snapshot) {
        return AwosheButton(
          height: 50.0,
          width: double.infinity,
          buttonColor: primaryColor,
          onTap: () async {
            bool results = await bloc.submit(profileNameFormKey.currentState);
            if (results) {
              ShowFlushToast(
                context, ToastType.INFO, "Profile updated successfully",
                callback: () => Navigator.pop(context),
              );
            }
          },
          childWidget: (snapshot.data == true)
              ? DotSpinner()
              : Text(
                  Localization.of(context).save,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
        );
      },
    );

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: profileNameFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              nameField,
              userNameField,
              locationField,
              aboutMeField,
              saveButton,
              const Padding(padding: EdgeInsets.only(top: 20.0))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('profileNameTabForm');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AwosheSimpleAppBar(
        title: "Edit Personal Info ",
      ),
      body: StreamBuilder<bool>(
          stream: bloc.asyncCallObservable,
          initialData: false,
          builder: (context, snapshot) => profileNameForm()),
    );
  }
}
