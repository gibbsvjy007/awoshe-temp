import 'dart:async';
import 'package:Awoshe/logic/bloc/registration/registration_event.dart';
import 'package:Awoshe/services/validations.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'registration_state.dart';

class RegistrationFormBloc with Validators  {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _userNameController = BehaviorSubject<String>();

  @override
  Stream<String> get name => _nameController.stream.transform(validateName);

  @override
  Stream<String> get userName => _userNameController.stream.transform(validateUserName);

  @override
  Stream<String> get email => _emailController.stream.transform(validateEmail);

  @override
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  @override
  Stream<bool> get submitValid =>
      Observable.combineLatest3(email, password, name, (e, p, n) => true);

  // sink
  @override
  Function(String) get changeEmail => _emailController.sink.add;

  @override
  Function(String) get changePassword => _passwordController.sink.add;

  @override
  Function(String) get changeName => _nameController.sink.add;

  @override
  Function(String) get changeUserName => _userNameController.sink.add;

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _userNameController.close();
  }

  @override
  // TODO: implement currentState
  RegistrationState get currentState => null;

  @override
  void dispatch(RegistrationEvent event) {
    // TODO: implement dispatch
  }

  @override
  // TODO: implement initialState
  RegistrationState get initialState => null;

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) {
    // TODO: implement mapEventToState
    return null;
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(RegistrationEvent event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<RegistrationEvent, RegistrationState> transition) {
    // TODO: implement onTransition
  }

//  @override
//  // TODO: implement state
//  Stream<RegistrationState> get state => null;

  @override
  Stream<RegistrationState> transformEvents(Stream<RegistrationEvent> events, Stream<RegistrationState> Function(RegistrationEvent event) next) {
    // TODO: implement transformEvents
    return null;
  }

  @override
  Stream<RegistrationState> transformStates(Stream<RegistrationState> states) {
    // TODO: implement transformStates
    return null;
  }

  @override
  // TODO: implement event
  Stream<RegistrationEvent> get event => null;

//  @override
//  Stream<RegistrationState> transform(Stream<RegistrationEvent> events, Stream<RegistrationState> Function(RegistrationEvent event) next) {
//    // TODO: implement transform
//    return null;
//  }
}

abstract class RegistrationFormBlocAbstract {
  Function(String) get changeEmail;
  Function(String) get changePassword;
  Function(String) get changeName;
  Function(String) get changeUserName;

  Stream<String> get email;
  Stream<String> get password;
  Stream<String> get name;
  Stream<String> get userName;

  Stream<bool> get submitValid;

  void dispose();
}
