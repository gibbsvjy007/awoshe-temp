import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => 'AuthenticationInitial';
}

class Authenticating extends AuthenticationState {
  @override
  String toString() => 'Authenticating';
}

class Authenticated extends AuthenticationState {
  final String email;

  Authenticated({@required this.email}) : super([email]);
  @override
  String toString() => 'Authenticated';
}

class ResetPasswordSuccess extends AuthenticationState {
  @override
  String toString() => 'Authenticated';
}

class ResetPasswordError extends AuthenticationState {
  final String error;

  ResetPasswordError({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
