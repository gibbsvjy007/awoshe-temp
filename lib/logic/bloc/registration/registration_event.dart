import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  RegistrationEvent([List props = const []]) : super(props);
}

class RegistrationEventProcess extends RegistrationEvent {
  final String email;
  final String password;
  final String name;
  final String handle;

  final RegistrationEventType event;
  RegistrationEventProcess(
      {this.event, this.email, this.handle, this.name, this.password})
      : super([event, email, password, name, handle]);
}

enum RegistrationEventType { none, working }
