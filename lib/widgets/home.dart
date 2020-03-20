import 'package:flashcards/blocs/authentication/bloc.dart';
import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/screens/home_screen.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loader_centered.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
    @required this.authenticationRepository,
    @required this.deckRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final DeckRepository deckRepository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return HomeScreen(
            authenticationRepository: authenticationRepository,
            deckRepository: deckRepository,
          );
        }
        if (state is AuthenticationUnauthenticated) {
          return LoginScreen(
            authenticationRepository: authenticationRepository,
          );
        }
        if (state is AuthenticationLoading) {
          return LoaderCentered();
        }
        return LoaderCentered();
      },
    );
  }
}
