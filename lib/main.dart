import 'package:flashcards/authentication/authentication_repository.dart';
import 'package:flashcards/screens/home.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/bloc/authentication_event.dart';
import 'authentication/bloc/bloc.dart';
import 'login/login_page.dart';

final storage = new FlutterSecureStorage();

Future<void> main() async {
  final authenticationRepository = AuthenticationRepository();

  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authenticationRepository: authenticationRepository)
          ..add(AppStarted());
      },
      child: App(authenticationRepository: authenticationRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  App({Key key, @required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          accentColor: Colors.cyan),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          accentColor: Color(0xFF268979),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white12,
          )),
      onGenerateRoute: router.generateRoute,
      navigatorKey: navigatorKey,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state.runtimeType.toString());
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(authenticationRepository: authenticationRepository,);
          }
          if (state is AuthenticationLoading) {
            return CircularProgressIndicatorCentered();
          }
          return CircularProgressIndicatorCentered();
        },
      ),
    );
  }
}
