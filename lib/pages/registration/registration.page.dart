import 'package:Awoshe/components/toprightclosefab.dart';
import 'package:Awoshe/logic/bloc/authentication/authentication_bloc.dart';
import 'package:Awoshe/logic/bloc/registration/registration_bloc.dart';
import 'package:Awoshe/pages/registration/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SafeArea(
        child: AwosheTopRightCloseFab(
          onPressed: null,
        ),
      ),
      body: BlocProvider(
        builder: (context) {
          return RegistrationBloc(
            authenticationBloc: Provider.of<AuthenticationBloc>(context, listen: false),
          );
        },
        child: RegistrationForm(),
      ),
    );
  }

}