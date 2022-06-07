import 'dart:async';
import 'package:Awoshe/services/validations.dart';
import 'package:rxdart/rxdart.dart';

class LoginFormBloc with Validators  {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _forgotPasswordEmailController = BehaviorSubject<String>();

  // Validators
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<String> get forgotPasswordEmail => _forgotPasswordEmailController.stream.transform(validateEmail);

  // sink (inputs)
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeForgotPasswordEmail => _emailController.sink.add;
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _forgotPasswordEmailController.close();
  }

}

