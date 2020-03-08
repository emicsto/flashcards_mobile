import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/screens/home.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'authentication/authentication_bloc.dart';
import 'authentication/authentication_event.dart';
import 'authentication/authentication_state.dart';
import 'screens/login.dart';

final storage = new FlutterSecureStorage();

Future<void> main() async {
  final authRepository = AuthRepository();

  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)
          ..add(AppStarted());
      },
      child: App(authRepository: authRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository authRepository;

  App({Key key, @required this.authRepository}) : super(key: key);

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
//      initialRoute: _initialRoute,
      navigatorKey: navigatorKey,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state.runtimeType.toString());
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return Login(authRepository: authRepository,);
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
