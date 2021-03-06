import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/widgets/home.dart';
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
          flashcardRepository: flashcardRepository,
        ),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          deckBloc: BlocProvider.of<DeckBloc>(context),
        )..add(AppStarted()),
      ),
    ],
    child: App(
      authenticationRepository: authenticationRepository,
      deckRepository: deckRepository,
      flashcardRepository: flashcardRepository,
    ),
  ));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;

  App(
      {Key key,
      @required this.authenticationRepository,
      @required this.deckRepository,
      @required this.flashcardRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          accentColor: Colors.teal,
          ),

      darkTheme: ThemeData(
          canvasColor: Color(0xFF17181A),
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          accentColor: Color(0xFF268979),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white12,
          ),
        cardColor: Color(0xFF242529),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color(0xFF17181A),
          iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 8
        ),
      ),
      onGenerateRoute: router.generateRoute,
      navigatorKey: navigatorKey,
      home: Home(
          authenticationRepository: authenticationRepository,
          deckRepository: deckRepository,
          flashcardRepository: flashcardRepository),
    );
  }
}
