import 'package:flashcards/blocs/authentication/bloc.dart';
import 'package:flashcards/blocs/login/bloc.dart';
import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/login_form.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class LoginScreen extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  LoginScreen({Key key, @required this.authenticationRepository})
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
