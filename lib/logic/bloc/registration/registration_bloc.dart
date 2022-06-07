import 'package:Awoshe/logic/api/auth_api.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/bloc/registration/registration_event.dart';
import 'package:Awoshe/logic/bloc/registration/registration_state.dart';
import 'package:Awoshe/logic/services/signup_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthenticationBloc authenticationBloc;

  RegistrationBloc({
    @required this.authenticationBloc,
  })  : assert(authenticationBloc != null);

  @override
  RegistrationState get initialState => RegistrationInitial();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    print(authenticationBloc.state);
    if (event is RegistrationEventProcess) {
      yield RegistrationBusy();

      print('Registration of ${event.email}/${event.password}/${event.name}');

      try {
        SignupService registerService = SignupService(
            email: event.email, password: event.password, name: event.name, handle: event.handle);

        bool isUserNameTaken = await AuthApi.checkIfUsernameExists(event.handle);
        if (isUserNameTaken) {
          yield RegistrationWarning(error: "Username already taken. Please use different username.");
          return;
        }
        await registerService.register();
        // Inform that we have successfuly authenticated, or not
        yield RegistrationSuccess();
      } on PlatformException catch (e) {
        print("BLOC: Registration failed.");
        print(e.message);
        yield RegistrationFailure(error: e.message);
      }
    }
  }
}
