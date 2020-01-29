import 'package:flashcards/router.dart';
import 'package:flashcards/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'screens/login.dart';

final storage = new FlutterSecureStorage();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  storage.deleteAll();
  signInSilently();
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
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.orange),
      onGenerateRoute: router.generateRoute,
      initialRoute: LoginViewRoute,
      navigatorKey: navigatorKey,
    );
  }
}
