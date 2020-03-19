import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/blocs/authentication/authentication_bloc.dart';
import 'package:flashcards/blocs/authentication/authentication_event.dart';
import 'package:flutter/cupertino.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authenticationRepository,
    @required this.authenticationBloc,
  })  : assert(authenticationRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        await authenticationRepository.loginWithGoogle();
        authenticationBloc.add(LoggedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
