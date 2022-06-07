import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/pages/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      // Creates   a black screen so I commented it. may be Marcos can help with it
      /*floatingActionButton: AwosheTopRightCloseFab(
        onPressed:null ),*/
      body: Container(
        child: BlocProvider.value(
          value: BlocProvider.of<AuthenticationBloc>(context),
          child: LoginForm(),
        ),
      ),

    );
  }
}
