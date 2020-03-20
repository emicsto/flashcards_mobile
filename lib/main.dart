import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/screens/home_screen.dart';
import 'package:flashcards/widgets/loader_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/authentication/authentication_event.dart';
import 'blocs/authentication/bloc.dart';
import 'blocs/flashcards/bloc.dart';
import 'blocs/deck/bloc.dart';
import 'repositories/flashcard_repository.dart';
import 'screens/login_screen.dart';

final storage = new FlutterSecureStorage();

Future<void> main() async {
  final authenticationRepository = AuthenticationRepository();
  final deckRepository = DeckRepository();
  final flashcardRepository = FlashcardRepository();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<FlashcardsBloc>(
        create: (context) => FlashcardsBloc(
          flashcardRepository: flashcardRepository,
        ),
      ),
      BlocProvider<DeckBloc>(
        create: (context) => DeckBloc(
          deckRepository: deckRepository,
          flashcardsBloc: BlocProvider.of<FlashcardsBloc>(context),
        ),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        )..add(AppStarted()),
      ),
    ],
    child: App(
      authenticationRepository: authenticationRepository,
      deckRepository: deckRepository,
    ),
  ));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final DeckRepository deckRepository;

  App(
      {Key key,
      @required this.authenticationRepository,
      @required this.deckRepository})
      : super(key: key);

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
      ),
    );
  }
}
