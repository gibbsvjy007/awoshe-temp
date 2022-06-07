import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String email;
  final String password;
  final AuthenticationEventType event;
  AuthenticationEventLogin(
      {this.event,
      this.email,
      this.password})
      : super([event, email, password]);
}

class AuthenticationEventReset extends AuthenticationEvent {
  final String email;
  final AuthenticationEventType event;
  AuthenticationEventReset(
      {@required this.event, @required this.email})
      : super([event, email]);
  @override
  String toString() =>
      'AuthenticationEventReset { event: $event, email: $email }';
}

class AuthenticationEventLogout extends AuthenticationEvent {}

enum AuthenticationEventType { none, working, forgotPassword }
