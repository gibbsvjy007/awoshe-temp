import 'package:equatable/equatable.dart';

abstract class ApplicationInitializationEvent extends Equatable {
  ApplicationInitializationEvent([List props = const []]) : super(props);
}

class ApplicationInitializationStart extends ApplicationInitializationEvent {
  final ApplicationInitializationEventType type;
  ApplicationInitializationStart({
    this.type,
  }) : super([type]);
}

enum ApplicationInitializationEventType {
  start,
  initialized,
}
