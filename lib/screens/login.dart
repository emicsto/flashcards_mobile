import 'package:flashcards/authentication/bloc.dart';
import 'package:flashcards/login/bloc.dart';
import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: ['email'],
);

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class Login extends StatelessWidget {
  final AuthRepository authRepository;

  Login({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFF268979),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authRepository: authRepository,
          );
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: LoginForm(),
        )
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({
    Key key,
  }) : super(key: key);

  final loginText = Text(
    "Login",
    style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4),
  );

  final loginImage = SizedBox.fromSize(
    child: SvgPicture.asset(
      'images/login.svg',
    ),
    size: Size(280.0, 280.0),
  );


  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed());
    }

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              loginText,
              loginImage,
              Container(
                height: 50,
                child: state is LoginLoading
                    ? Center(child: CircularProgressIndicator())
                    : GoogleSignInButton(
                    onPressed: state is! LoginLoading
                        ? _onLoginButtonPressed
                        : null),
              ),
            ]);
      },
    );
  }
}
