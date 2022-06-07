import 'package:Awoshe/constants.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_event.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_state.dart';
import 'package:Awoshe/logic/services/login_services.dart';
import 'package:Awoshe/logic/stores/auth/auth_store.dart';
import 'package:Awoshe/logic/stores/user/user_store.dart';
import 'package:Awoshe/models/user_details/user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>  {
  final UserStore userStore;
  final AuthStore authStore;

  AuthenticationBloc({
    @required this.userStore,
    @required this.authStore,
  })  : assert(userStore != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  UserDetails currentUser = UserDetails.empty();

  setUserDetails(UserDetails userDetails) {
    print("AuthenticationBloc:: " + userDetails.toJson().toString());
    currentUser = userDetails;
    // if there is no currency the default will be US dollar.
    currentUser.currency ??= DEFAULT_CURRENCY;
    userStore.setUserDetails(userDetails); /// setting the current user information
  }


  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationEventLogin) {
      // Inform that we are proceeding with the authentication
      yield Authenticating();

      print(event.email);
      print(event.password);

      try {

        await authStore.loginWithAccount(
            email: event.email, password: event.password);
        // Inform that we have successfuly authenticated, or not
        if (event.event == AuthenticationEventType.working) {
          authStore.setInternetPresence(true);
          yield Authenticated(email: event.email);
        }
      }

      on PlatformException catch (e) {
        print("Authentication failed.");
        print(e.message);
        yield AuthenticationFailure(error: e.message);
      }
    }
    if (event is AuthenticationEventReset) {
      print("hakshkfhakshkfash");
      print(event.email);
      try {
        ForgotPasswordService fService = ForgotPasswordService(email: event.email);
        await fService.forgotPassword();
        // Inform that we have successfuly authenticated, or not
        if (event.event == AuthenticationEventType.forgotPassword) {
          yield ResetPasswordSuccess();
        }
      } on PlatformException catch (e) {
        print("Authentication failed.");
        print(e.message);
        yield AuthenticationFailure(error: e.message);
      }
    }

    if (event is AuthenticationEventLogout) {
      yield AuthenticationInitial();
    }
  }
}
