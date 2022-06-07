import 'package:Awoshe/services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class SignupService {
  String email;
  String password;
  String name;
  String handle;

  SignupService(
      {@required this.email, @required this.password, @required this.name, @required this.handle});

  Future<FirebaseUser> register() async {
    print(this.email);
    print(this.password);
    FirebaseUser user = await AuthenticationService.instance
        .signUpWithAccount(this.email, this.password, this.name, this.handle);
    await user.sendEmailVerification();
    return user;
  }
}
