import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
class ApplicationInitializationState extends Equatable {
  ApplicationInitializationState([List props = const []]) : super(props);
}
class ApplicationInitializationInitial extends ApplicationInitializationState {
  int progress;

  ApplicationInitializationInitial({this.progress = 0}) : super([progress]);

  @override
  String toString() => 'ApplicationInitializationInitial';
}


class ApplicationInitializationProgressing extends ApplicationInitializationState {
  final int progress;

  ApplicationInitializationProgressing({@required this.progress}) : super([progress]);

  @override
  String toString() => 'ApplicationInitializationProgressing { progress: $progress }';
}

class ApplicationInitializationDone extends ApplicationInitializationState {
  int progress = 100;

  ApplicationInitializationDone({this.progress}) : super([progress]);

  @override
  String toString() => 'ApplicationInitializationDone { progress: $progress }';
}