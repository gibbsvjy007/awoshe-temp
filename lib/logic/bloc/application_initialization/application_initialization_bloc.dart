import 'package:Awoshe/logic/bloc/application_initialization/application_initialization_event.dart';
import 'package:Awoshe/logic/bloc/application_initialization/application_initialization_state.dart';
import 'package:bloc/bloc.dart';

class ApplicationInitializationBloc extends Bloc<
    ApplicationInitializationEvent, ApplicationInitializationState> {

  @override
  ApplicationInitializationState get initialState => ApplicationInitializationInitial();

  @override
  Stream<ApplicationInitializationState> mapEventToState(ApplicationInitializationEvent event) async* {


    if (event is ApplicationInitializationStart) {
      for (int progress = 0; progress < 101; progress += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        yield ApplicationInitializationProgressing(progress: progress);
        if (progress == 100) {
          yield ApplicationInitializationDone(progress: progress);
        }
      }
    }
  }
}
