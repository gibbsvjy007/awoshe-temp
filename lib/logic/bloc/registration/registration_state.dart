import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  RegistrationState([List props = const []]) : super(props);
}

class RegistrationInitial extends RegistrationState {
  @override
  String toString() => 'RegistrationInitial';
}

class RegistrationBusy extends RegistrationState {
  @override
  String toString() => 'RegistrationBusy';
}

class RegistrationSuccess extends RegistrationState {
  @override
  String toString() => 'RegistrationSuccess';
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}

class RegistrationWarning extends RegistrationState {
  final String error;

  RegistrationWarning({@required this.error}) : super([error]);

  @override
  String toString() => 'RegistrationWarning { error: $error }';
}
