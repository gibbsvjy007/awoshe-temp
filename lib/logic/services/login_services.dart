import 'package:Awoshe/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class LoginService {
    String email;
    String password;

    LoginService({@required this.email, @required this.password});

    Future<FirebaseUser> login() async {
      print(this.email);
      print(this.password);
      return AuthenticationService.instance
          .signInWithAccount(this.email, this.password);
    }

    Future<Null> forgotPassword() async {
      print(email);
    }
}

class ForgotPasswordService {
  String email;

  ForgotPasswordService({@required this.email});

  Future<Null> forgotPassword() async {
    print("________forgotPassword");
    print(email);
    await AuthenticationService.instance.sendResetPasswordEmail(email);
  }
}