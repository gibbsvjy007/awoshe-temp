import 'package:Awoshe/logic/api/auth_api.dart';
import 'package:Awoshe/logic/stores/profile/profile_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProfileNameTabBloc {
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController aboutMeController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();

  final BehaviorSubject<String> _fullNameStreamController = BehaviorSubject();
  final BehaviorSubject<String> _userNameStreamController = BehaviorSubject();
  final BehaviorSubject<String> _aboutMeStreamController = BehaviorSubject();
  final BehaviorSubject<String> _locationStreamController = BehaviorSubject();
  final BehaviorSubject<bool> _asyncCallSubject = BehaviorSubject();

  Observable<String> get userName => _userNameStreamController.stream;
  Observable<String> get aboutMe => _aboutMeStreamController.stream;
  Observable<String> get fullName => _fullNameStreamController.stream;
  Observable<String> get location => _locationStreamController.stream;

  Observable<bool> get asyncCallObservable => _asyncCallSubject.stream;

  bool autoValidate = false;
  bool _isInAsyncCall = false;
  bool _isUserNameExists = false;
  final UserDetails userDetails;
  final UserStore userStore;
  final ProfileStore profileStore;

  ProfileNameTabBloc({this.userDetails, this.userStore, this.profileStore});

  // event
  changeUserName(String newText) {
    _changeControllerText(userNameController, newText);
    if (!_userNameStreamController.isClosed)
      _userNameStreamController.sink.add(newText);
  }

  // event
  changeFullName(String newText) {
    _changeControllerText(fullNameController, newText);
    if (!_fullNameStreamController.isClosed)
      _fullNameStreamController.sink.add(newText);
  }

  // event
  changeAboutMe(String newText) {
    _changeControllerText(aboutMeController, newText);
    if (!_aboutMeStreamController.isClosed)
      _aboutMeStreamController.sink.add(newText);
  }

  // event
  changeLocation(String newText) {
    _changeControllerText(locationController, newText);
    if (!_locationStreamController.isClosed)
      _locationStreamController.sink.add(newText);
  }

  // event
  loadProfileInfo() async {
    changeFullName(userDetails.name);
    changeUserName(userDetails.handle);
    changeAboutMe(userDetails.description);
    changeLocation(userDetails.location);
  }

  // event
  restartOriginalData() {
    if (fullNameController.text.isEmpty)
      changeFullName(userDetails.name);

    if (userNameController.text.isEmpty)
      changeUserName(userDetails.handle);

    if (aboutMeController.text.isEmpty)
      changeAboutMe(userDetails.description);

    if (locationController.text.isEmpty)
      changeAboutMe(userDetails.location);

    autoValidate = false;
  }

  _changeControllerText(TextEditingController controller, String newText) =>
      controller.text = newText;

  String validateNameField(String text) {
    print('validateNameField()');
    if (text.isEmpty) return "Name field can't be empty";

    return null;
  }

  String validateUserName(String text) {
    print('validateUserName()');
    if (text.isEmpty) return "Username field can't be empty";

    return null;
  }

  void _changeIsInAsyncCall(bool value) {
    _isInAsyncCall = value;
    _asyncCallSubject.sink.add(_isInAsyncCall);
  }

  Future<bool> _userNameExists(String handle) async {
    bool flag = false;
    if (handle.isEmpty) return !flag;
    if (userDetails.handle == handle) {
      flag = false;
    } else {
      flag = await AuthApi.checkIfUsernameExists(handle);
      print("user name is already taken");
    }
    return flag;
  }

  // event
  Future<bool> submit(FormState formState) async {
    formState.save();
    _changeIsInAsyncCall(true);
    bool isValid = await _validateData(formState);
    print("isValid " + isValid.toString());
    if (isValid) {
      await updateProfileData();
    }
    _changeIsInAsyncCall(false);
    return isValid;
  }

  // THis mehtod should be in service class
  // event
  Future<void> updateProfileData() async {
    UserDetails updatedDetails = userDetails.copyWith(
      name: fullNameController.text,
      location: locationController.text,
      description: aboutMeController.text,
      handle: userNameController.text,
    );
    userStore.saveProfile(
      name: updatedDetails.name,
      location: updatedDetails.location,
      description: updatedDetails.description,
      handle: updatedDetails.handle,
    );
    profileStore.setUserDetails(updatedDetails);
    userStore.setUserDetails(updatedDetails);
  }

  Future<bool> _validateData(FormState formState) async {
    _isUserNameExists = await _userNameExists(userNameController.text);
    print("_isUserNameExists " + _isUserNameExists.toString());
    if (formState.validate()) {
      if (!_isUserNameExists) {
        return true;
      }
    }
    return false;
  }

  void dispose() {
    print('profileName bloc dispose');
    _fullNameStreamController?.close();
    _userNameStreamController?.close();
    _aboutMeStreamController?.close();
    _locationStreamController?.close();
    _asyncCallSubject?.close();
  }
}
