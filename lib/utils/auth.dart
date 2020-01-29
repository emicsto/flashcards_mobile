import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/screens/login.dart';

import '../router.dart';

void loginWithGoogle() {
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
}

void signInSilently() {
  googleSignIn.signInSilently().then((result) {
    result.authentication.then((googleKey) {
      sendIdToken(googleKey.idToken);
    }).catchError((err) {
      print('inner error');
    });
  }).catchError((err) {
    loginWithGoogle();
  });
}
