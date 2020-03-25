import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/router.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final DeckBloc deckBloc;
  final storage = new FlutterSecureStorage();

  AuthenticationBloc({@required this.authenticationRepository, @required this.deckBloc})
      : assert(authenticationRepository != null), assert(deckBloc != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      await storage.deleteAll();
      try {
        await authenticationRepository.signInSilently();
      } on Exception {
        await authenticationRepository.loginWithGoogle();
      }

      final bool hasToken = await authenticationRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      deckBloc.add(LoadDecks());
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await authenticationRepository.signOut();
      yield AuthenticationUnauthenticated();
    }
  }
}
