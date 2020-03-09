import 'package:flashcards/authentication/bloc/bloc.dart';
import 'package:flashcards/login/bloc/bloc.dart';
import 'package:flashcards/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_form.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class LoginPage extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  LoginPage({Key key, @required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              authenticationRepository: authenticationRepository,
            );
          },
          child: LoginForm()),
    );
  }
}
