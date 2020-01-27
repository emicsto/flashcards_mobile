import 'package:flashcards/router.dart';
import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flashcards/router.dart' as router;

import 'screens/login.dart';

final storage = new FlutterSecureStorage();

Future<void> main() {
  WidgetsFlutterBinding.ensureInitialized();

  storage.deleteAll();
//TODO extract
  googleSignIn.signInSilently().then((result) {
    result.authentication.then((googleKey) {
      sendIdToken(googleKey.idToken);
    }).catchError((err) {
      print('inner error');
    });
  }).catchError((err) {
    googleSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        sendIdToken(googleKey.idToken).then((_) {
          navigatorKey.currentState.pushReplacementNamed(HomeViewRoute);
        });
      }).catchError((err) {
        print('inner error');
      });
    }).catchError((err) {
      print('error occured');
    });
  });

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

//        home: storage.read(key: "name") == null ? Login() : HomePage(title: "Home"),
    );
  }
}
