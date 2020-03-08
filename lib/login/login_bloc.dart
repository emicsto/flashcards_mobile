import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/authentication/authentication_bloc.dart';
import 'package:flashcards/authentication/authentication_event.dart';
import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authRepository,
    @required this.authenticationBloc,
  })  : assert(authRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        await authRepository.loginWithGoogle();
        authenticationBloc.add(LoggedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
