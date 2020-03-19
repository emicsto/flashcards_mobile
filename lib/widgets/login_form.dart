import 'package:flashcards/blocs/login/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        return Center(
          child: Column(
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
              ]),
        );
      },
    );
  }
}
