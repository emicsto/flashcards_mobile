import 'package:flashcards/router.dart';
import 'package:flashcards/screens/home.dart';
import 'package:flashcards/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'screens/login.dart';

final storage = new FlutterSecureStorage();
var _initialRoute;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storage.deleteAll();
  await signInSilently();

  _initialRoute = await storage.read(key: "accessToken") == null
      ? LoginViewRoute
      : HomeViewRoute;

  runApp(App());
}

class App extends StatelessWidget {
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
      initialRoute: _initialRoute,
      navigatorKey: navigatorKey,
    );
  }
}
